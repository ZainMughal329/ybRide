import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:credit_card_type_detector/credit_card_type_detector.dart';
import 'package:credit_card_type_detector/models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yb_ride/api/api.dart';
import 'package:yb_ride/components/snackbar_widget.dart';
import 'package:yb_ride/helper/app_constants.dart';
import 'package:yb_ride/helper/session_controller.dart';
import 'package:yb_ride/models/creditCart.dart';
import 'package:yb_ride/screens/pages/Checkout/index.dart';
import 'dart:math';
import 'package:random_string/random_string.dart';


class CheckOutCon extends GetxController {
  final state = CheckOutState();

  //  for hide container
  void hideContainer() {
    state.isContainerVisible.value = false;
  }

  var priceLoading = false.obs;

  setPriceLoading(bool val) {
    priceLoading.value = val;
  }

  void priceLoadingFunc() {
    setPriceLoading(true);
    // Simulating a delay of 2 seconds
    Future.delayed(Duration(seconds: 2), () {
      setPriceLoading(false);
    });
    update();
  }

//   for update total price when click on driver check box
  void updateTotalPrice_Drivers() {
    if (state.driversCheckBoxVal.value) {
      state.totalPrice.value = 2.11 +
          (state.driversCheckBoxVal.value ? 150 : 0) +
          (state.extraSwitchVal.value ? 13 : 0) +
          (state.standard_protection.value ? 53.98 : 0) +
          (state.essential_protection.value ? 28.98 : 0) +
          (state.i_have_own.value ? 0 : 0);
    } else {
      state.totalPrice.value = 2.11;
    }
  }

//   for update total price when click on extras switch button
  void updateTotalPrice_Extras() {
    if (state.extraSwitchVal.value) {
      state.totalPrice.value = 2.11 +
          (state.driversCheckBoxVal.value ? 150 : 0) +
          (state.extraSwitchVal.value ? 13 : 0) +
          (state.standard_protection.value ? 53.98 : 0) +
          (state.essential_protection.value ? 28.98 : 0) +
          (state.i_have_own.value ? 0 : 0);
    } else {
      state.totalPrice.value = 2.11;
    }
  }

//   for update total price when click on custom Covergae_CDW

  void updateTotalPrice_Custom_CDW() {
    if (state.cdwSwitchVal.value) {
      state.totalPrice.value = 2.11 +
          (state.cdwSwitchVal.value ? 24.99 : 0) +
          (state.rcliSwitchVal.value ? 24.99 : 0) +
          (state.sliSwitchVal.value ? 199.99 : 0);
    } else {
      state.totalPrice.value = 2.11;
    }
  }

  //   for update total price when click on custom Covergae_RCLI

  void updateTotalPrice_Custom_RCLI() {
    if (state.rcliSwitchVal.value) {
      state.totalPrice.value = 2.11 +
          (state.rcliSwitchVal.value ? 24.99 : 0) +
          (state.cdwSwitchVal.value ? 24.99 : 0) +
          (state.sliSwitchVal.value ? 19.99 : 0);
    } else {
      state.totalPrice.value = 2.11;
    }
  }

//   for update total price when click on custom Covergae_SLI
  void updateTotalPrice_Custom_SLI() {
    if (state.sliSwitchVal.value) {
      state.totalPrice.value = 2.11 +
          (state.rcliSwitchVal.value ? 24.99 : 0) +
          (state.cdwSwitchVal.value ? 24.99 : 0) +
          (state.sliSwitchVal.value ? 19.99 : 0);
    } else {
      state.totalPrice.value = 2.11;
    }
  }

  void subtractCustomCoverageValue(String coverageType) {
    double coverageValue = 0;

    switch (coverageType) {
      case 'CDW':
        coverageValue = 24.99;
        break;
      case 'RCLI':
        coverageValue = 24.99;
        break;
      case 'SLI':
        coverageValue = 19.99;
        break;
    // Add more cases for other custom coverages if needed
    }

    state.totalPrice.value -= coverageValue;
  }

//   for update total price when click on custom Coverage

  void updateTotalPrice_Coverage_std_prot() {
    if (state.standard_protection.value) {
      state.totalPrice.value = 2.11 +
          (state.driversCheckBoxVal.value ? 150 : 0) +
          (state.extraSwitchVal.value ? 13 : 0) +
          (state.standard_protection.value ? 53.98 : 0) +
          (state.essential_protection.value ? 28.98 : 0) +
          (state.i_have_own.value ? 0 : 0);
    } else {
      state.totalPrice.value = 2.11;
    }
  }

  void updateTotalPrice_Coverage_essential_prot() {
    if (state.essential_protection.value) {
      state.totalPrice.value = 2.11 +
          (state.driversCheckBoxVal.value ? 150 : 0) +
          (state.extraSwitchVal.value ? 13 : 0) +
          (state.standard_protection.value ? 53.98 : 0) +
          (state.essential_protection.value ? 28.98 : 0) +
          (state.i_have_own.value ? 0 : 0);
    } else {
      state.totalPrice.value = 2.11;
    }
  }

  void updateTotalPrice_Coverage_have_Own() {
    if (state.i_have_own.value) {
      state.totalPrice.value = 2.11 +
          (state.driversCheckBoxVal.value ? 150 : 0) +
          (state.extraSwitchVal.value ? 13 : 0) +
          (state.standard_protection.value ? 53.98 : 0) +
          (state.essential_protection.value ? 28.98 : 0) +
          (state.i_have_own.value ? 0 : 0);
    } else {
      state.totalPrice.value = 2.11;
    }
  }

  void setDataLoaded(bool val) {
    state.dataLoaded.value = val;
  }

  Future<void> getCheckoutPayments() async {
    setDataLoaded(false);
    try {
      CollectionReference usersCollection =
      APis.db.collection('checkoutPayment');
      QuerySnapshot querySnapshot = await usersCollection.get();

      // Check if there are any documents in the collection
      if (querySnapshot.docs.isNotEmpty) {
        // Get the first document
        QueryDocumentSnapshot firstDocument = querySnapshot.docs.first;

        // Get the details from the document
        state.delivery = firstDocument['delivery'];
        state.CDW = firstDocument['CDW'];
        state.RCLI = firstDocument['RCLI'];
        state.SLI = firstDocument['SLI'];
        state.essential = firstDocument['essential'];
        state.licenseFee = firstDocument['licenseFee'];
        state.standard = firstDocument['standard'];
        state.unlimitedMiles = firstDocument['unlimitedMiles'];
        state.assistance = firstDocument['assistance'];
        state.pickupLoc = firstDocument['pickUpLoc'];
        AppConstants.deliveryCharges = firstDocument['delivery'];
        AppConstants.pickUpLoc = firstDocument['pickUpLoc'];
        fetchCardDetails();
        getReceiptCharges();
        setDataLoaded(true);
      } else {
        Snackbar.showSnackBar(
            'Error', 'Something went wrong', Icons.error_outline_outlined);
        setDataLoaded(true);
      }
    } catch (e) {
      Snackbar.showSnackBar(
          'Error', e.toString(), Icons.error_outline_outlined);

      setDataLoaded(true);
    }
  }

  Future<void> getReceiptCharges() async{
    try{
      CollectionReference usersCollection =
      APis.db.collection('receipt_charges');
      QuerySnapshot querySnapshot = await usersCollection.get();

      // Check if there are any documents in the collection
      if (querySnapshot.docs.isNotEmpty) {
        // Get the first document
        QueryDocumentSnapshot firstDocument = querySnapshot.docs.first;

        // Get the details from the document
        AppConstants.bostonPoliceFees = double.parse((firstDocument['Boston Convention Center Financing Surcharge']).toString());
        AppConstants.bostonParking = double.parse((firstDocument['Boston Parking Surcharge']).toString());
        AppConstants.bostonConventionCenter = double.parse((firstDocument['Boston Police Training Fees']).toString());
        AppConstants.tempDeposit = double.parse((firstDocument['tempDeposit']).toString());
        AppConstants.salesTaxPercentage = double.parse((firstDocument['salesTaxPercentage']).toString());

      }
    }catch(e){
      Snackbar.showSnackBar(
          'Error', e.toString(), Icons.error_outline_outlined);
    }
  }

  //
  void addInTotalPrice(double? price, bool withRentDays) {
    if(withRentDays==true){
      double? newprice = AppConstants.rentDays*price!;
      state.totalPrice.value = state.totalPrice.value + newprice;
    }else if(withRentDays==false){
      state.totalPrice.value = state.totalPrice.value + price!;
    }

  }

  void subtractFromTotalPrince(double? price, bool withRentDays) {
    if(withRentDays == true){
      double? newprice = AppConstants.rentDays*price!;
      state.totalPrice.value = state.totalPrice.value - newprice!;
    }else if(withRentDays==false){
      state.totalPrice.value = state.totalPrice.value - price!;
    }

  }

  void removingAllValuesInChekout() {
    if (state.standard_protection.value == true) {
      subtractFromTotalPrince(state.standard,true);
    }
    if (state.essential_protection.value == true) {
      subtractFromTotalPrince(state.essential,true);
    }
    if (state.i_have_own.value == true) {}
    state.standard_protection.value = false;
    state.essential_protection.value = false;
    state.i_have_own.value = false;
  }

  Future<void> fetchCardDetails() async {
    try {
      DocumentSnapshot doc = await APis.db
          .collection('credit_cards')
          .doc(SessionController().userId.toString())
          .get();
      if (doc.exists) {
        state.cardNumber.value = doc['number'];
        state.expNumber.value = doc['expiryDate'];
        state.cvvNumber.value = doc['cvv'];
        state.zipCode.value = doc['zipCode'];
        storeDetailsinConstants(doc['number'],
            doc['cvv'], doc['expiryDate'], doc['zipCode']);

        getCardType(state.cardNumber.value);
      } else {}
    } catch (e) {
      Snackbar.showSnackBar("YB-Ride", "Error fetching Details\nRetry again",
          Icons.error_outline);
    }
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

  setCardLoading(bool val) {
    state.cardLoading.value = val;
  }

  Future<void> saveCreditCardDataToFirestore(String number,
      String expiryDate, String cvv, String zipCode,
      BuildContext context) async {
    setCardLoading(true);
    try {
      await APis.db
          .collection('credit_cards')
          .doc(SessionController().userId)
          .set(CreditCardModel(
          id: SessionController().userId,
          number: number,
          cvv: cvv,
          expiryDate: expiryDate,
          zipCode: zipCode)
          .toJson())
          .then((value) {
        storeDetailsinConstants(number,
            cvv, expiryDate, zipCode);
        getCardType(number);
        setCardLoading(false);
        Navigator.pop(context);
        Snackbar.showSnackBar('YB-Ride', "Payment Saved", Icons.done);
      }).onError((error, stackTrace) {
        setCardLoading(false);
        Snackbar.showSnackBar(
            'YB-Ride', "Error ${error.toString()}", Icons.done);
      });
    } catch (error) {
      setCardLoading(false);
      Snackbar.showSnackBar('YB-Ride', "Error ${error.toString()}", Icons.done);
    }
  }


  void storeDetailsinConstants(String cardNumber, String cvvNumber,
      String expDate, String zipCode) {
    AppConstants.cardNumber = cardNumber;
    AppConstants.cardCvv = cvvNumber;
    AppConstants.cardExp = expDate;
    AppConstants.cardZip = zipCode;
    state.cardAdded.value = true;
  }


  Future<void> checkPromoCode(BuildContext context, String code) async {
    try {
      final doc = await APis.db.collection('promoCodes').where(
          'code', isEqualTo: code).get();

      if (doc.docs.isNotEmpty) {
        final amountInt = doc.docs[0]['discountAmount'];
        final amount = double.parse(amountInt.toString());
        state.promoDiscount.value = amount;
        await checkAndAddValueToUserList(context, code, amount);
      } else {
        Snackbar.showSnackBar(
            "YB-Ride", 'PromoCode not found', Icons.error_outline);
      }
    } catch (e) {
      Snackbar.showSnackBar('YB-Ride', e.toString(), Icons.error_outline);
    }
  }


  Future<void> checkAndAddValueToUserList(BuildContext context,
      String promoCode, double amount) async {
    // Reference to the "user" collection and document with ID "1231231231"
    DocumentReference userDocumentRef = APis.db.collection('users').doc(
        SessionController().userId);

    // Fetch the current document snapshot
    final userDocument = await userDocumentRef.get();
    List list = userDocument['listOfCodes'];
    if (list.length == 0) {
      await userDocumentRef.update({
        'listOfCodes': FieldValue.arrayUnion([promoCode]),
      });
      // handle logic for giving discount
      applyDiscount(amount);
      state.promoCodeapplied.value = true;
      state.promoDiscount.value = amount;
      Navigator.pop(context);
      print("give discount");
    } else {
      if (list != 0 && !list.contains(promoCode)) {
        // Update the document to add the new value to the list
        await userDocumentRef.update({
          'listOfCodes': FieldValue.arrayUnion([promoCode]),
        });
        applyDiscount(amount);
        state.promoCodeapplied.value = true;
        state.promoDiscount.value = amount;
        Navigator.pop(context);
        print('give discount');
      } else if (list.length != 0 && list.contains(promoCode)) {
        // Handle the case where the value already exists in the list
        // handle logic for not giving discount
        // return false;

        Snackbar.showSnackBar(
            'YB-Ride', 'Already Used Promo Code', Icons.error_outline);
      }
    }
  }


  void applyDiscount(amount) {
    subtractFromTotalPrince(amount,false);
    AppConstants.isPromoApplied=true;
    AppConstants.promoDiscountAmount=amount;
  }

//
//   bool checkNecessaryFieldsAdded() {
//     if (state.vehicle_delivery.value == true ||
//         state.vehicle_pickup.value == true) {
//       if (state.standard_protection.value == true ||
//           state.essential_protection.value == true
//           || state.i_have_own.value == true ||
//           state.customCoverage.value == true) {
//         if (state.cardAdded.value == true) {
//           return true;
//         } else {
//           false;
//         }
//       } else {
//         return false;
//       }
//     }{
//       return false;
//     }
// }

  bool checkNecessaryFieldsAdded() {
    if (state.vehicle_delivery.value == true ||
        state.vehicle_pickup.value == true) {
      if (state.standard_protection.value == true ||
          state.essential_protection.value == true
          || state.i_have_own.value == true ||
          state.customCoverage.value == true) {
       return true;
      } else {
        return false;
      }
    }else{
      return false;
    }
  }

void storeUserDetailsinConstants(){
    AppConstants.custFirstName = state.fNameCon.text.trim().toString();
    AppConstants.custLastName = state.lNameCon.text.trim().toString();
    AppConstants.custEmail = state.emailCon.text.trim().toString();
    AppConstants.custPhoneNo = getRawPhoneNumber(state.phoneNumberCon.text.trim().toString());
    state.personalInfoAdded.value=true;
    print("values added in constants");
    Snackbar.showSnackBar("YB-Ride", "Details Saved", Icons.done_all);

  }
  String getRawPhoneNumber(String formatted) {
    // Remove any non-numeric characters
    return formatted.replaceAll(RegExp(r'[^0-9]'), '');
  }

  void addInTotalCustomCoverageValue(double amount){
    AppConstants.totalCustomCoverage=AppConstants.totalCustomCoverage+amount;
  }



  String generateRandomString() {
    String prefix = "INV-";
    String randomDigits = randomNumeric(8);
    String randomLetters = randomAlpha(4);
    return prefix + randomDigits + randomLetters;
  }


}
