import 'package:get/get.dart';
import 'package:yb_ride/screens/settings/controller.dart';

class SettingsBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingsController>(() => SettingsController());
  }

}