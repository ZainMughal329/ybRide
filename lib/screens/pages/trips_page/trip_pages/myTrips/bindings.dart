import 'package:get/get.dart';
import 'package:yb_ride/screens/pages/trips_page/controller.dart';
import 'package:yb_ride/screens/pages/trips_page/trip_pages/myTrips/controller.dart';

class MyTripBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyTripController>(() => MyTripController());
  }

}