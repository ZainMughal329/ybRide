

import 'package:get/get.dart';
import 'package:yb_ride/screens/pages/Checkout/index.dart';

class CheckOutCon extends GetxController{
  final state = CheckOutState();
  //  for hide container
  void hideContainer() {
    state.isContainerVisible.value = false;
  }



}