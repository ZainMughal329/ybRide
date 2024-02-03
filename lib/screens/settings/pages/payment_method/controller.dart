

import 'package:credit_card_validator/credit_card_validator.dart';
import 'package:credit_card_validator/validation_results.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yb_ride/components/snackbar_widget.dart';
import 'package:yb_ride/screens/settings/pages/payment_method/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../models/creditCart.dart';

class PaymentCon extends GetxController{

  final state =PaymentState();


  void setLoading(bool val){
    state.loading.value = val;
  }


  Future<void> saveCreditCardDataToFirestore(
      String id,
      String number,
      String expiryDate,
      String zipCode,
      String cvc
      ) async {
    setLoading(true);
    try {
      await FirebaseFirestore.instance.collection('credit_cards').doc(id).set(
        CreditCardModel(
            id: id,
            number: number,
            cvc: cvc,
            expiryDate: expiryDate,
            zipCode: zipCode).toJson()

      ).then((value){
        setLoading(false);
        Snackbar.showSnackBar('YB-Ride', "Payment Saved", Icons.done);
      }).onError((error, stackTrace){
        Snackbar.showSnackBar('YB-Ride', "Error ${error.toString()}", Icons.done);
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


}