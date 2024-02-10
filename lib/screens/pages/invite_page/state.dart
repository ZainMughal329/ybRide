

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class InviteState{

  RxBool loading = true.obs;
  RxBool carBooked = false.obs;
  RxBool shareLoading = false.obs;
  TextEditingController referralContr = TextEditingController();
}