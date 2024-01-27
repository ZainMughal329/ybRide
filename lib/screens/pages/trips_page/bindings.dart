import 'package:get/get.dart';
import 'package:yb_ride/screens/pages/trips_page/controller.dart';
import 'package:yb_ride/screens/pages/trips_page/trip_pages/myTrips/controller.dart';
import 'package:yb_ride/screens/pages/trips_page/trip_pages/sharedTrips/controller.dart';

class TripBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TripController>(() => TripController());
    Get.lazyPut<MyTripController>(() => MyTripController());
    Get.lazyPut<SharedTripController>(() => SharedTripController());

  }

}