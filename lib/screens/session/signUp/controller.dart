import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yb_ride/api/api.dart';
import 'package:yb_ride/components/snackbar_widget.dart';
import 'package:yb_ride/helper/app_constants.dart';
import 'package:yb_ride/helper/app_helpers.dart';
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
        AppConstants.referralDiscount =
            double.parse((doc['referralDiscount']).toString());
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
        createUser(userinfo, context);
        if(state.refCon.text.isNotEmpty){
          checkReferralCode(state.refCon.text.trim().toString());
        }else if(state.refCon.text.isEmpty){
          Get.offAllNamed(RoutesName.applicationScreen);
        }


        clearControllers();
      }).onError((error, stackTrace) {
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
    print(";;;;;;;;;;;;;;;;;;;;");
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
            addReferralDiscountToId(docId);
            listOfCode.remove(referralCode);
            await FirebaseFirestore.instance
                .collection('users')
                .doc(docId)
                .update({'referralList': listOfCode});
          } else {

          }
        },
      );
      Get.offAllNamed(RoutesName.applicationScreen);
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> addReferralDiscountToId(String id) async {
    try {
      await APis.db.collection('users').doc(id).set({
        'referralDiscount': AppConstants.referralDiscount,
      },SetOptions(merge: true)).then((value) {
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
  }
}
