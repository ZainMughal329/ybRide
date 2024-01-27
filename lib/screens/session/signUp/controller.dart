import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:yb_ride/api/api.dart';
import 'package:yb_ride/helper/app_helpers.dart';
import 'package:yb_ride/helper/session_controller.dart';
import 'package:yb_ride/routes/routes_name.dart';
import 'package:yb_ride/screens/session/signUp/inded.dart';

import '../../../models/usermodel.dart';

class SignUpController extends GetxController {
  final state = SignUpState();

  // user signUp Functions {
  void registerUserWithEmailAndPassword(
      UserModel userinfo, String email, password, BuildContext context) async {
    showProgressIndicator(context);
    try {
      await APis.auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        userinfo.id = APis.auth.currentUser!.uid.toString();
        SessionController().userId = APis.auth.currentUser!.uid.toString();;
        // SessionController().userId = value.user!.uid.toString();
        // StorePrefrences sp = StorePrefrences();
        // sp.setIsFirstOpen(true);
        createUser(userinfo, context);
        // Snackbar.showSnackBar('Success', 'Successfully create an account.',Icons.done_all);
        Navigator.pop(context);
        clearControllers();
      }).onError((error, stackTrace) {
        // Snackbar.showSnackBar("Error", error.toString(), Icons.error_outline);
        Navigator.pop(context);
      });
    } catch (e) {
      Navigator.pop(context);
      // Snackbar.showSnackBar("Error", e.toString(), Icons.error_outline);
    }
  }

  createUser(UserModel user, BuildContext context) async {
    showProgressIndicator(context);
    await APis.db
        .collection('users')
        .doc(APis.auth.currentUser!.uid)
        .set(user.toJson())
        .whenComplete(() {
      print('Account created Successfully');

      Navigator.pop(context);
      // StorePrefrences sp = StorePrefrences();
      // sp.setIsFirstOpen(true);
      Get.offAllNamed(RoutesName.applicationScreen);
      print('success');
    }).catchError((error, stackTrace) {
      // Snackbar.showSnackBar("Error", error.toString(), Icons.error_outline);
      Navigator.pop(context);
    });
  }

  void storeUser(UserModel user, BuildContext context, String email,
      String pass) async {
    registerUserWithEmailAndPassword(user, email, pass, context);
  }

  clearControllers() {
    state.emailCon.clear();
    state.passCon.clear();
    state.nameCon.clear();
  }
}
