import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yb_ride/api/api.dart';
import 'package:yb_ride/components/snackbar_widget.dart';
import 'package:yb_ride/helper/app_constants.dart';
import 'package:yb_ride/screens/settings/inded.dart';

class SettingsController extends GetxController {
  final state = SettingsState();

  Future<void> fetchUrls() async {
    try {
      await APis.db
          .collection('constants')
          .doc('constants')
          .get()
          .then((value) {
        AppConstants.fbLink = value['fbLink'];
        AppConstants.instagramLink = value['instaLink'];
        AppConstants.twitterLink = value['twitterLink'];
      }).onError((error, stackTrace) {
        Snackbar.showSnackBar("YB-Ride", error.toString(), Icons.error_outline);
      });
    } catch (e) {
      Snackbar.showSnackBar("YB-Ride", e.toString(), Icons.error_outline);
    }
  }

  Future<void> launchInstagram() async {

    final url = AppConstants.instagramLink;
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(
        Uri.parse(url),
      );
    } else {
      Snackbar.showSnackBar("YB-Ride", "Error launching", Icons.error_outline);
    }
  }

  Future<void> launchTwitter() async {

    final url = AppConstants.twitterLink;
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(
        Uri.parse(url),
      );
    } else {
      Snackbar.showSnackBar("YB-Ride", "Error launching", Icons.error_outline);
    }
  }
  Future<void> launchFacebook() async {

    final url = AppConstants.fbLink;
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(
        Uri.parse(url),
      );
    } else {
      Snackbar.showSnackBar("YB-Ride", "Error launching", Icons.error_outline);
    }
  }
}
