import 'package:get/get.dart';
import 'package:yb_ride/screens/settings/controller.dart';
import 'package:yb_ride/screens/settings/pages/profile/controller.dart';

class ProfileBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(() => ProfileController());
  }

}