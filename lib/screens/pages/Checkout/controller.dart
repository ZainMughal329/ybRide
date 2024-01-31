

import 'package:get/get.dart';
import 'package:yb_ride/screens/pages/Checkout/index.dart';

class CheckOutCon extends GetxController{
  final state = CheckOutState();
  //  for hide container
  void hideContainer() {
    state.isContainerVisible.value = false;
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