

import 'package:get/get.dart';
import 'package:yb_ride/screens/settings/pages/payment_method/controller.dart';
class PaymentBindings implements Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<PaymentCon>(() => PaymentCon());
  }
}