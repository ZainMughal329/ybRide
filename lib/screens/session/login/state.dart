import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginState {
  final emailCon = TextEditingController();
  final passCon = TextEditingController();
  RxBool isObscure = true.obs;

}