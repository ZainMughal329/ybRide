

import 'package:get/get.dart';

import 'controller.dart';

class onBoardingBindings implements Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<OnBoardingController>(() => OnBoardingController());
  }
}
