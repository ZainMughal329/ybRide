import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:yb_ride/api/api.dart';
import 'package:yb_ride/components/snackbar_widget.dart';
import 'package:yb_ride/helper/app_constants.dart';
import 'package:yb_ride/helper/app_helpers.dart';
import 'package:yb_ride/helper/notification_services.dart';
import 'package:yb_ride/helper/session_controller.dart';
import 'package:yb_ride/routes/routes_name.dart';
import 'package:yb_ride/screens/session/signUp/inded.dart';

import '../../../models/usermodel.dart';

class SignUpController extends GetxController {
  final state = SignUpState();

  Future<void> fetchAppLinks() async {
    try {
      var doc = await APis.db.collection('constants').doc('constants').get();

      if (doc.exists) {
        AppConstants.playStoreLink = doc["playStoreLink"];
        AppConstants.appStoreLink = doc["appStoreLink"];
        AppConstants.APPReferralDiscount =
            double.parse((doc['referralDiscount']).toString());
        print("Amount of referral code");
        print(AppConstants.APPReferralDiscount);
      }
    } catch (e) {
      Snackbar.showSnackBar('YB-Ride', e.toString(), Icons.error_outline);
    }
  }

  // user signUp Functions {
  void registerUserWithEmailAndPassword(
      UserModel userinfo, String email, password, BuildContext context) async {
    showProgressIndicator(context);
    try {
      await APis.auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        userinfo.id = APis.auth.currentUser!.uid.toString();
        SessionController().userId = APis.auth.currentUser!.uid.toString();
        getUserReferralDiscount();
        createUser(userinfo, context);
        if(state.refCon.text.isNotEmpty){
          checkReferralCode(state.refCon.text.trim().toString());
        }else if(state.refCon.text.isEmpty){
          Get.offAllNamed(RoutesName.applicationScreen);
        }
        clearControllers();
      }).onError((error, stackTrace) {
        Navigator.pop(context);
        Snackbar.showSnackBar("Error", error.toString(), Icons.error_outline);
      });
    } catch (e) {
      Navigator.pop(context);
      Snackbar.showSnackBar("Error", e.toString(), Icons.error_outline);
    }
  }

  createUser(UserModel user, BuildContext context) async {
    await APis.db
        .collection('users')
        .doc(APis.auth.currentUser!.uid)
        .set(user.toJson())
        .whenComplete(() {
      Snackbar.showSnackBar("YB-Ride", "Account Created", Icons.done);
    }).catchError((error, stackTrace) {
      Snackbar.showSnackBar("Error", error.toString(), Icons.error_outline);
    });
  }

  void storeUser(
      UserModel user, BuildContext context, String email, String pass) async {
    fetchAppLinks();
    registerUserWithEmailAndPassword(user, email, pass, context);
  }

  Future<void> checkReferralCode(String referralCode) async {
    print("inside check referalCode function");
    try {
      // Assuming 'users' is the collection in Firestore
      QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('users').get();

      // Loop through each document in the collection
      querySnapshot.docs.forEach(
            (doc) async{
          var listOfCode = doc['referralList'];


          // Check if "XACDS" is present in the list of codes
          if (listOfCode.contains(referralCode)) {

            var docId = doc['id'];
            print("id of user shared referal code is" + docId.toString());
            addReferralDiscountToId(docId);

            listOfCode.remove(referralCode);

            await FirebaseFirestore.instance
                .collection('users')
                .doc(docId)
                .update({'referralList': listOfCode}).then((value) {
                  print("update referral list called");
            });
          } else {

          }
        },
      );
      Get.offAllNamed(RoutesName.applicationScreen);
    } catch (e) {
      Snackbar.showSnackBar("YB-Ride", e.toString(), Icons.error_outline);
    }
  }

  Future<void> addReferralDiscountToId(String id) async {
    print("function addReferralDiscountToId() executed");
    try {
      print("--------------");
      print("user id is "+id.toString());
      print("Referaal amount is is "+AppConstants.referralDiscount.toString());
      await APis.db.collection('users').doc(id).set({
        'referralDiscount': AppConstants.referralDiscount+AppConstants.APPReferralDiscount,
      },
          SetOptions(merge: true)).then((value) {
            print("Inside then of addReferralDiscountToId()");
        Get.offAllNamed(RoutesName.applicationScreen);
      }).onError((error, stackTrace) {
        Snackbar.showSnackBar("YB-Ride", error.toString(), Icons.error);
      });
    } catch (e) {
      Snackbar.showSnackBar("YB-Ride", e.toString(), Icons.error);
    }
  }

  clearControllers() {
    state.emailCon.clear();
    state.passCon.clear();
    state.nameCon.clear();
    state.refCon.clear();
  }

  Future<void> getUserReferralDiscount() async{
    var user = await APis.db.collection('users').doc(SessionController().userId).get();
    if(user.exists){
      AppConstants.referralDiscount=double.parse((user['referralDiscount']).toString());
    }
  }



  static User get user => APis.auth.currentUser!;

  static Future<bool> userExists() async {
    return (await APis.db.collection('users').doc(user.uid).get()).exists;
  }

  static Future<void> createGoogleUser() async {
    NotificationServices services = NotificationServices();
    late String token;
    await services.getToken().then((value) {
      token = value;
    });
    // log('message'+token.toString());
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
    ).onError((error, stackTrace){
      Snackbar.showSnackBar("YB-Ride", error.toString(), Icons.error_outline);
    });
  }

  handleGoogleSignIn(BuildContext context) async {
    showProgressIndicator(context);
    _signInWithGoogle().then((user) async {
      // SessionController().userId = user!.uid.toString();

      if (user != null) {
        SessionController().userId = user.user!.uid.toString();
        if ((await userExists())) {
          getUserReferralDiscount();
          return Get.offAndToNamed(RoutesName.applicationScreen);
        } else {
          await createGoogleUser().then((value) {
            getUserReferralDiscount();
            return Get.offAndToNamed(RoutesName.applicationScreen);
          });
        }
      }
    }).onError((error, stackTrace){
      Navigator.pop(context);
      Snackbar.showSnackBar("YB-Ride", 'Error while google signing', Icons.error_outline);
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
      Snackbar.showSnackBar("YB-Ride", e.toString(), Icons.error_outline);
    }
  }

  List<String> list = [];

  fetchUserCollectionData() async {
    QuerySnapshot snapshot = await APis.db.collection('users').get();
    if(snapshot.docs.isNotEmpty) {
      snapshot.docs.forEach((element) {
        var snap = element['email'];
        // log('snap:${snap}');
        list.add(snap);
      });
    }
    // print('len:'+list.length.toString());
  }

  Future<bool> checkIfUserExists(String email) async {
    try {
      var snapshot = await APis.db
          .collection('users')
          .where('email', isEqualTo: email)
          .get();
      return snapshot.docs.isNotEmpty;
    } catch (e) {
      Snackbar.showSnackBar("YB-Ride", e.toString(), Icons.error_outline);
      // Handle any errors
      // print(e);
      return false;
    }
  }






}
