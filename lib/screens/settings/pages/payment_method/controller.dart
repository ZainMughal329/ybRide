

import 'package:get/get.dart';
import 'package:yb_ride/screens/settings/pages/payment_method/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../models/creditCart.dart';

class PaymentCon extends GetxController{

  final state =PaymentState();


  Future<void> saveCreditCardDataToFirestore(
      String id,
      String number,
      String expiryDate,
      String zipCode,
      String cvc
      ) async {
    try {
      await FirebaseFirestore.instance.collection('credit_cards').doc(id).set(
        CreditCardModel(
            id: id,
            number: number,
            cvc: cvc,
            expiryDate: expiryDate,
            zipCode: zipCode).toJson()

      );
      print('Credit card data saved to Firestore successfully.');
    } catch (error) {
      print('Error saving credit card data: $error');
    }
  }

  void onExpiryDateChange(String value) {
    final String expiry = state.expiryDate.text;
    state.expiryDate.text =
    expiry.startsWith(RegExp('[2-9]')) ? '0$expiry' : expiry;
  }

}