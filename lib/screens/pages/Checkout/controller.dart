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
        fetchCardDetails();
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

  void addInTotalPrice(double? price) {
    state.totalPrice.value = state.totalPrice.value + price!;
  }

  void subtractFromTotalPrince(double? price) {
    state.totalPrice.value = state.totalPrice.value - price!;
  }

  void removingAllValuesInChekout() {
    if (state.standard_protection.value == true) {
      subtractFromTotalPrince(state.standard);
    }
    if (state.essential_protection.value == true) {
      subtractFromTotalPrince(state.essential);
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

        getCardType(state.cardNumber.value);
      } else {
      }
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

  setCardLoading( bool val){
    state.cardLoading.value=val;
  }

  Future<void> saveCreditCardDataToFirestore(String number,
      String expiryDate, String cvv, String zipCode,BuildContext context) async {
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


}
