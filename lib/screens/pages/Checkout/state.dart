

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
  // Getting the vehicle delivery

  final vehicle_delivery = false.obs;
  final vehicle_pickup = false.obs;
  //  Coverage section
  final standard_protection =false.obs;
  final essential_protection=false.obs;
  final i_have_own=false.obs;

  // Custom Coverage
  final cdwSwitchVal = false.obs;
  final rcliSwitchVal = false.obs;
  final sliSwitchVal = false.obs;

}