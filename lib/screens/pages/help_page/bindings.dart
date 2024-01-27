

import 'package:get/get.dart';

import 'controller.dart';

class HelpBindings implements Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<HelpCon>(() => HelpCon());
  }

}