
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:yb_ride/helper/session_controller.dart';

class PaymentState{

  final cardNumber =TextEditingController();
  final expiryDate = TextEditingController();
  final cvv = TextEditingController();
  final zipCode = TextEditingController();
  String documentId = SessionController().userId.toString();
  bool isCvvFocused = false;
  RxBool cardExist = false.obs;

  RxString cardType = "".obs;

  final RxString expiryDateVal = ''.obs;
  RxBool loading = false.obs;


}