
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PaymentState{

  final cardNumber =TextEditingController();
  final cardNumberFocus = FocusNode();
  final expiryDate = TextEditingController();
  final expiryDateFocus=FocusNode();
  final cvc = TextEditingController();
  final cvcFocus =FocusNode();
  final zipCode = TextEditingController();
  final zipCodeFocus = FocusNode();

  // RxString  cardumber = ''.obs;
  // RxString  expirydate = ''.obs;
  // RxString  zipcode = ''.obs;
  // RxString  cvvCode = ''.obs;
  bool isCvvFocused = false;



}