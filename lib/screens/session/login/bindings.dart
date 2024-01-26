import 'package:get/get.dart';
import 'package:yb_ride/screens/session/login/controller.dart';

class LoginBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
  }

}