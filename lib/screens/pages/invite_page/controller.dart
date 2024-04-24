import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:yb_ride/api/api.dart';
import 'package:yb_ride/components/snackbar_widget.dart';
import 'package:yb_ride/helper/app_constants.dart';
import 'package:yb_ride/helper/session_controller.dart';
import 'package:yb_ride/screens/pages/invite_page/inded.dart';

class InviteCon extends GetxController {
  final state = InviteState();

  setLoading(bool value) {
    state.loading.value = value;
  }

  Future<void> fetchFirstOrder() async {
    setLoading(true);
    try {
      var data = await APis.db
          .collection('all_bookings')
          .where('id', isEqualTo: SessionController().userId.toString())
          .get();

      if (data.docs.length == 0) {
        state.carBooked.value = false;
        setLoading(false);
      } else {
        state.carBooked.value = true;
        setLoading(false);
      }
    } catch (e) {
      setLoading(false);
      Snackbar.showSnackBar('YB-Ride', e.toString(), Icons.error_outline);
    }
  }

  // code for invite logic
  setShareLoading(bool val) {
    state.shareLoading.value = val;
  }

  void handelShareTap(String referralCode, BuildContext context) async {
    setShareLoading(true);
    try {
      final result = await Share.shareWithResult(
          'Check out YB-Ride\nThe best car rental application on Play Store and App Store\nUse my referral code ${state.referralContr.text} to sign-up\n${AppConstants.playStoreLink}\n${AppConstants.appStoreLink}');
      if (result.status == ShareResultStatus.success) {
        storeReferralCode(referralCode, context);
      } else {
        Snackbar.showSnackBar(
            "YB-Ride", 'Something went wrong', Icons.error_outline);
      }
    } catch (e) {
      Snackbar.showSnackBar("YB-Ride", e.toString(), Icons.error_outline);
    }
  }

  void generateCouponCode() {
    const String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    var random = new Random();
    state.referralContr.text = String.fromCharCodes(
      List.generate(6,
          (index) => characters.codeUnitAt(random.nextInt(characters.length))),
    );
  }

  Future<void> storeReferralCode(
      String referralCode, BuildContext context) async {
    setShareLoading(true);
    try {
      DocumentReference userDocumentRef =
          APis.db.collection('users').doc(SessionController().userId);
      final userDocument = await userDocumentRef.get();
      List list = userDocument['referralList'];
      if (list.length == 0) {
        await userDocumentRef.update({
          'referralList': FieldValue.arrayUnion([referralCode]),
        });
        Navigator.pop(context);
        Snackbar.showSnackBar("YB-Ride", "code shared", Icons.done);
        setShareLoading(false);
      } else {
        if (list != 0 && !list.contains(referralCode)) {
          // Update the document to add the new value to the list
          await userDocumentRef.update({
            'referralList': FieldValue.arrayUnion([referralCode]),
          });
          Snackbar.showSnackBar("YB-Ride", "code shared", Icons.done);
          setShareLoading(false);
          Navigator.pop(context);
        } else if (list.length != 0 && list.contains(referralCode)) {
          Snackbar.showSnackBar(
              'YB-Ride', 'Try adding a new referral code', Icons.error_outline);
          setShareLoading(false);
          Navigator.pop(context);
        }
      }
      setShareLoading(false);
    } catch (e) {
      setShareLoading(false);
      Navigator.pop(context);
    }
  }

// Future<void> checkPromoCode(BuildContext context, String code) async {
//   try {
//     final doc = await APis.db.collection('promoCodes').where(
//         'code', isEqualTo: code).get();
//
//     if (doc.docs.isNotEmpty) {
//       final amountInt = doc.docs[0]['discountAmount'];
//       final amount = double.parse(amountInt.toString());
//       // state.promoDiscount.value = amount;
//       await checkAndAddValueToUserList(context, code, amount);
//     } else {
//       Snackbar.showSnackBar(
//           "YB-Ride", 'PromoCode not found', Icons.error_outline);
//     }
//   } catch (e) {
//     Snackbar.showSnackBar('YB-Ride', e.toString(), Icons.error_outline);
//   }
// }
}
