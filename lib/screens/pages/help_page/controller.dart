

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yb_ride/api/api.dart';
import 'package:yb_ride/components/snackbar_widget.dart';
import 'package:yb_ride/helper/app_constants.dart';
import 'package:yb_ride/screens/pages/help_page/inded.dart';

class HelpCon extends GetxController{
  final state = HelpState();


  Future<void> fetchContactDetails() async {
    try {
      await APis.db
          .collection('constants')
          .doc('constants')
          .get()
          .then((value) {
        AppConstants.ybEmail = value['ybEmail'];
        AppConstants.ybPhone = value['ybPhone'];
      }).onError((error, stackTrace) {
        Snackbar.showSnackBar("YB-Ride", error.toString(), Icons.error_outline);
      });
    } catch (e) {
      Snackbar.showSnackBar("YB-Ride", e.toString(), Icons.error_outline);
    }
  }
}