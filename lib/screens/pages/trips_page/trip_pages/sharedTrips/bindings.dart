import 'package:get/get.dart';
import 'package:yb_ride/screens/pages/trips_page/controller.dart';
import 'package:yb_ride/screens/pages/trips_page/trip_pages/sharedTrips/controller.dart';

class SharedTripBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SharedTripController>(() => SharedTripController());
  }

}