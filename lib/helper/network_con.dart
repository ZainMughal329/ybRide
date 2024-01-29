import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yb_ride/components/heading_text_widget.dart';
import 'package:yb_ride/helper/app_colors.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void _updateConnectionStatus(ConnectivityResult connectivityResult) {

    if (connectivityResult == ConnectivityResult.none) {
      Get.rawSnackbar(
          messageText: HeadingTextWidget(title:
          'PLEASE CONNECT TO THE INTERNET',
            fontSize: 16,
            textColor: Colors.white,

          ),
          isDismissible: false,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(days: 1),
          backgroundColor: AppColors.buttonColor,
          icon : const Icon(Icons.wifi_off, color: Colors.white, size: 35,),
          margin: EdgeInsets.zero,
          snackStyle: SnackStyle.FLOATING
      );
    } else {
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }
    }
  }
}