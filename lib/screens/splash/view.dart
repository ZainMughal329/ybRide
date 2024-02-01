import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yb_ride/main.dart';
import 'package:yb_ride/screens/splash/controller.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.checkLogin();
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBgClr,
      body: Center(child: Text('Splash View'),),
    );
  }
}
