
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PaymentState{

  final cardNumber =TextEditingController();
  final expiryDate = TextEditingController();
  final cvc = TextEditingController();
  final zipCode = TextEditingController();
  String documentId = DateTime.now().millisecondsSinceEpoch.toString();
  bool isCvvFocused = false;



}