

import 'dart:developer';

import 'package:get/get.dart';
import 'package:yb_ride/screens/pages/Checkout/index.dart';

class CheckOutCon extends GetxController{
  final state = CheckOutState();
  //  for hide container
  void hideContainer() {
    state.isContainerVisible.value = false;
  }

  var isLoading = true.obs;

  void init() {

    // Simulating a delay of 2 seconds
    Future.delayed(Duration(seconds: 3), () {
      isLoading.value = false;
      log('init:'+isLoading.value.toString());

    });
    log('init0:'+isLoading.value.toString());

    isLoading.value = true;
    log('init1:'+isLoading.value.toString());
    update();

  }


//   for update total price when click on driver check box
  void updateTotalPrice_Drivers() {
    if (state.driversCheckBoxVal.value) {
     state. totalPrice.value = 2.11 + 150;
    } else {
      state.totalPrice.value = 2.11;
    }
  }



//   for update total price when click on extras switch button
  void updateTotalPrice_Extras() {
    if (state.extraSwitchVal.value) {
      state. totalPrice.value = 2.11 + 13;
    } else {
      state.totalPrice.value = 2.11;
    }
  }




}