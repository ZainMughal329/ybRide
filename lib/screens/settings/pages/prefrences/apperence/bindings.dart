import 'package:get/get.dart';
import 'package:yb_ride/screens/settings/controller.dart';
import 'package:yb_ride/screens/settings/pages/prefrences/apperence/controller.dart';
import 'package:yb_ride/screens/settings/pages/prefrences/controller.dart';
import 'package:yb_ride/screens/settings/pages/profile/controller.dart';

class AppearanceBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AppearanceController>(() => AppearanceController());
  }

}