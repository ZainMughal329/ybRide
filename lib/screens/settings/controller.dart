import 'dart:developer';

import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yb_ride/screens/settings/inded.dart';

class SettingsController extends GetxController {
  final state = SettingsState();


  Future<void> launchInstagram() async {
    print('object');
    final url = state.instagramUrl;
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url),);
    } else {
      log( 'Could not launch $url');
    }
  }
}