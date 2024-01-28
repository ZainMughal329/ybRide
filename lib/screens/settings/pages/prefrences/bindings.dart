import 'package:get/get.dart';
import 'package:yb_ride/screens/settings/controller.dart';
import 'package:yb_ride/screens/settings/pages/prefrences/controller.dart';
import 'package:yb_ride/screens/settings/pages/profile/controller.dart';

class PreferenceBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PreferenceController>(() => PreferenceController());
  }

}