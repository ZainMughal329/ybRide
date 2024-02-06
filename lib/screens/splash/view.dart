import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yb_ride/helper/app_colors.dart';
import 'package:yb_ride/main.dart';
import 'package:yb_ride/screens/splash/controller.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.checkLogin();
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Image.asset('assets/appImages/bg.png',),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: mq.height*0.34,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),

              child: Center(
                child: Container(
                  height: 200,
                  width: 200,
                  // color: AppColors.buttonColor,
                  child: Image.asset('assets/appImages/circleLogo.png'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
