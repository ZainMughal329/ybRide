

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CheckOutState{


  var isContainerVisible = true.obs;
  final promoCodeCon= TextEditingController();


  // extras section
  final extraSwitchVal = false.obs;
  // bottom sheet
  final buttonVisible = false.obs;
//    driverSections
  final driversCheckBoxVal = false.obs;
//    total price
RxDouble totalPrice = 2.11.obs;


  final cdwSwitchVal = false.obs;
  final rcliSwitchVal = false.obs;
  final sliSwitchVal = false.obs;

}