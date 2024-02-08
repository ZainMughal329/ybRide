import 'package:get/get.dart';
import 'package:yb_ride/api/api.dart';
import 'package:yb_ride/helper/session_controller.dart';
import 'package:yb_ride/helper/shared_pref.dart';
import 'package:yb_ride/routes/routes_name.dart';

class SplashController extends GetxController {
  void checkLogin() async {
    final user = await APis.auth.currentUser;

    Future.delayed(
      Duration(seconds: 2),
      () {
        if (user != null) {
          SessionController().userId = user.uid.toString();
          Get.offNamed(RoutesName.applicationScreen,arguments: {
            'index':0,
          });
        } else {
          if(Pref().getIsFirstOpen() == true){
            Get.offNamed(RoutesName.loginScreen);
          }else{
            Get.offNamed(RoutesName.onBoardingScreen);
          }

        }
      },
    );
  }
}
