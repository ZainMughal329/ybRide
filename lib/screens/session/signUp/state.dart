import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignUpState {
  final loading = false.obs;
  final emailCon = TextEditingController();
  final passCon = TextEditingController();
  final nameCon = TextEditingController();
  final refCon = TextEditingController();

  RxBool isObscure = true.obs;

}