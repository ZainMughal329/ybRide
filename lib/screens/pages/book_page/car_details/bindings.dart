import 'package:get/get.dart';
import 'package:yb_ride/screens/pages/book_page/car_details/controller.dart';
import 'package:yb_ride/screens/splash/controller.dart';

class CarDetailsBindings implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<CarDetailsController>(() => CarDetailsController());
  }

}