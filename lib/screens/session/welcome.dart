import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yb_ride/components/heading_text_widget.dart';
import 'package:yb_ride/components/reuseable_button.dart';
import 'package:yb_ride/helper/app_colors.dart';
import 'package:yb_ride/routes/routes_name.dart';

import '../../main.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            child: Image.asset('assets/images/2.png'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: mq.height * .02),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Spacer(
                  flex: 2,
                ),
                Center(
                  child: Container(
                    height: mq.height * 0.2,
                    width: mq.height * 0.2,
                    color: Colors.black54,
                  ),
                ),
                Spacer(),
                HeadingTextWidget(
                  title: 'Welcome,',
                  textColor: AppColors.orangeColor,
                ),
                SizedBox(
                  height: mq.height * .02,
                ),
                HeadingTextWidget(
                  title: 'Long time',
                  textColor: Colors.black,
                  fontSize: 45,
                ),
                HeadingTextWidget(
                  title: 'no see.',
                  textColor: Colors.black,
                  fontSize: 45,
                ),
                SizedBox(
                  height: mq.height * .02,
                ),
                RoundButton(
                    title: 'Sign in',
                    onPress: () {
                      Get.toNamed(
                        RoutesName.loginScreen,
                      );
                    }),
                SizedBox(
                  height: mq.height * .01,
                ),
                Center(
                    child: InkWell(
                        onTap: () {
                          Get.toNamed(
                            RoutesName.signUpScreen,
                          );
                        },
                        child: HeadingTextWidget(
                          title: 'Create an account',
                          textColor: AppColors.orangeColor,
                        ))),
                SizedBox(
                  height: mq.height * .04,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
