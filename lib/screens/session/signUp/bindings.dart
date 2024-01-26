import 'package:get/get.dart';
import 'package:yb_ride/screens/session/signUp/controller.dart';

class SignUpBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpController>(() => SignUpController());
  }

}