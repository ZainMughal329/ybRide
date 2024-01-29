

import 'package:get/get.dart';
import 'package:yb_ride/screens/pages/Checkout/controller.dart';

class CheckOutBindings implements Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<CheckOutCon>(() => CheckOutCon());
  }

}