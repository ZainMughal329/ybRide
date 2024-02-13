import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yb_ride/helper/app_constants.dart';
import 'package:yb_ride/helper/session_controller.dart';
import 'package:yb_ride/screens/session/login/state.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:yb_ride/models/usermodel.dart';
import 'package:yb_ride/routes/routes_name.dart';
import 'dart:developer';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import '../../../api/api.dart';
import '../../../components/snackbar_widget.dart';
import '../../../helper/app_helpers.dart';
import '../../../helper/notification_services.dart';



class LoginController extends GetxController {
  final state = LoginState();

  static User get user => APis.auth.currentUser!;

  static Future<bool> userExists() async {
    return (await APis.db.collection('users').doc(user.uid).get()).exists;
  }

  static Future<void> createUser() async {
    NotificationServices services = NotificationServices();
    late String token;
   await services.getToken().then((value) {
      token = value;
    });
    log('message'+token.toString());
    final chatUser = UserModel(
        image: user.photoURL.toString(),
        name: user.displayName.toString(),
        id: user.uid.toString(),
        email: user.email.toString(),
        pushToken: token,
      dateTime: DateTime.now().millisecondsSinceEpoch.toString(),
      list: [],
      referralList: [],

    );
    SessionController().userId=user.uid.toString();

    await APis.db.collection('users').doc(APis.auth.currentUser!.uid).set(
          chatUser.toJson(),
        );
  }

  handleGoogleSignIn(BuildContext context) async {
    // showProgressIndicator(context);
    _signInWithGoogle().then((user) async {
      // SessionController().userId = user!.uid.toString();

      if (user != null) {
        SessionController().userId = user.user!.uid.toString();
        if ((await userExists())) {
          getUserReferralDiscount();
          return Get.offAndToNamed(RoutesName.applicationScreen);
        } else {
          await createUser().then((value) {
            getUserReferralDiscount();
            return Get.offAndToNamed(RoutesName.applicationScreen);
          });
        }
      }
    });
  }

  Future<UserCredential?> _signInWithGoogle() async {
    try {
      await InternetAddress.lookup('google.com');
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await APis.auth.signInWithCredential(credential);
    } catch (e) {
      log('\n_signInWithGoogle: $e');
      // Snackbar.showSnackBar('Something went wrong!!!', 'Check your internet.');
      return null;
    }
  }


// user Login function
  void loginUserWithEmailAndPassword(String email, password,BuildContext context) async {
    showProgressIndicator(context);
    try {
      await APis.auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        SessionController().userId = value.user!.uid.toString();
        getUserReferralDiscount();
        Navigator.pop(context);
        Get.offAllNamed(RoutesName.applicationScreen);
        state.emailCon.clear();
        state.passCon.clear();
      }).onError((error, stackTrace) {
        Snackbar.showSnackBar("Error", error.toString(), Icons.error_outline);
        Navigator.pop(context);
      });
    } on FirebaseAuthException catch (e) {
      Snackbar.showSnackBar("Error", e.toString(), Icons.error_outline);
      Navigator.pop(context);
    } catch (e) {
      Snackbar.showSnackBar("Error", e.toString(), Icons.error_outline);
      Navigator.pop(context);
    }
  }


  Future<void> getUserReferralDiscount() async{
    var user = await APis.db.collection('users').doc(SessionController().userId).get();
    if(user.exists){
      AppConstants.referralDiscount=double.parse((user['referralDiscount']).toString());
      print("=======================");
      print(double.parse((user['referralDiscount']).toString()));
    }
  }
}
