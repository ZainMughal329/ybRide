import 'package:get/get.dart';
import 'package:yb_ride/screens/pages/trips_page/controller.dart';

class TripBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TripController>(() => TripController());
  }

}