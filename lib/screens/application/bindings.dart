import 'package:get/get.dart';
import 'package:yb_ride/screens/application/controller.dart';

class ApplicationViewBindings implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<ApplicationViewController>(() => ApplicationViewController());
  }

}