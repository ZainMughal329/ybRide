import 'package:get/get.dart';
import 'package:yb_ride/screens/settings/controller.dart';
import 'package:yb_ride/screens/settings/pages/profile/controller.dart';
import 'package:yb_ride/screens/settings/pages/ybcar_surfer/controller.dart';

class SurferBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SurferController>(() => SurferController());
  }

}