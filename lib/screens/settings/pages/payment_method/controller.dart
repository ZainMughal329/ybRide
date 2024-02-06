import 'package:credit_card_type_detector/credit_card_type_detector.dart';
import 'package:credit_card_type_detector/models.dart';
import 'package:credit_card_validator/credit_card_validator.dart';
import 'package:credit_card_validator/validation_results.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:yb_ride/api/api.dart';
import 'package:yb_ride/components/snackbar_widget.dart';
import 'package:yb_ride/helper/app_constants.dart';
import 'package:yb_ride/helper/session_controller.dart';
import 'package:yb_ride/screens/settings/inded.dart';
import 'package:yb_ride/screens/settings/pages/payment_method/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yb_ride/screens/settings/pages/payment_method/view.dart';
import '../../../../models/creditCart.dart';

class PaymentCon extends GetxController {
  final state = PaymentState();

  void setLoading(bool val) {
    state.loading.value = val;
  }

  Future<void> fetchCardDetails() async{

    try{
      DocumentSnapshot doc = await APis.db.collection('credit_cards').doc(SessionController().userId.toString()).get();
      if(doc.exists){
        state.cardNumber.text = doc['number'];
        state.expiryDate.text = doc['expiryDate'];
        state.cvv.text = doc['cvv'];
        state.zipCode.text = doc['zipCode'];
        getCardType(state.cardNumber.text);
        state.cardExist.value=true;
        storeDetailsinConstants(doc['number'], doc['cvv'], doc['expiryDate'], doc['zipCode']);
      }else{
        state.cardExist.value=false;

        // Snackbar.showSnackBar("YB-Ride", "Add Valid Card Details", Icons.add_card_outlined);
      }
    }catch(e){

      Snackbar.showSnackBar("YB-Ride", "Error fetching Details\nRetry again", Icons.error_outline);
    }


  }




  Future<void> saveCreditCardDataToFirestore(String id, String number,
      String expiryDate, String zipCode, String cvv,BuildContext context) async {
    setLoading(true);
    try {
      await FirebaseFirestore.instance
          .collection('credit_cards')
          .doc(id)
          .set(CreditCardModel(
                  id: id,
                  number: number,
                  cvv: cvv,
                  expiryDate: expiryDate,
                  zipCode: zipCode)
              .toJson())
          .then((value) {
        storeDetailsinConstants(number,
            cvv, expiryDate, zipCode);
            getCardType(number);
            state.cardExist.value=true;
            fetchCardDetails();
        setLoading(false);
            PersistentNavBarNavigator
                .pushNewScreen(context,
                screen: SettingsView(),
                withNavBar: true);
        Snackbar.showSnackBar('YB-Ride', "Payment Saved", Icons.done);
      }).onError((error, stackTrace) {
        setLoading(false);
        Snackbar.showSnackBar(
            'YB-Ride', "Error ${error.toString()}", Icons.done);
      });
    } catch (error) {
      setLoading(false);
      Snackbar.showSnackBar('YB-Ride', "Error ${error.toString()}", Icons.done);
    }
  }

  void onExpiryDateChange(String value) {
    final String expiry = state.expiryDate.text;
    state.expiryDate.text =
        expiry.startsWith(RegExp('[2-9]')) ? '0$expiry' : expiry;
  }

  void getCardType(String cardNumber) {
    var types = detectCCType(cardNumber);
    if (types.contains(CreditCardType.visa())) {
      state.cardType.value = 'visa';
    } else if (types.contains(CreditCardType.mastercard())) {
      state.cardType.value = 'master';
    } else {
      state.cardType.value = 'default';
    }
  }


  void cleanControllers(){
    state.cardNumber.clear();
    state.cvv.clear();
    state.expiryDate.clear();
    state.zipCode.clear();
  }

  Future<void> delCard(BuildContext context) async{
    try{
      await APis.db.collection('credit_cards').doc(SessionController().userId.toString()).delete().then((value){
        removeDetailsinConstants();
        cleanControllers();
        state.cardExist.value=false;
        PersistentNavBarNavigator
            .pushNewScreen(context,
            screen: SettingsView(),
            withNavBar: true);
        Snackbar.showSnackBar("YB-Ride", "Card details deleted", Icons.done_all);
        setLoading(false);
      }).onError((error, stackTrace){
        Snackbar.showSnackBar("YB-Ride", error.toString(), Icons.done_all);
        setLoading(false);
      });
    }catch(e){
      setLoading(false);
      Snackbar.showSnackBar("YB-Ride", e.toString(), Icons.done_all);
    }

  }
  void storeDetailsinConstants(String cardNumber, String cvvNumber , String expDate, String zipCode){
    AppConstants.cardNumber = cardNumber;
    AppConstants.cardCvv = cvvNumber;
    AppConstants.cardExp = expDate;
    AppConstants.cardZip = zipCode;
  }

  void removeDetailsinConstants(){
    AppConstants.cardNumber = "";
    AppConstants.cardCvv = "cvvNumber";
    AppConstants.cardExp = "";
    AppConstants.cardZip = "";
  }

}
