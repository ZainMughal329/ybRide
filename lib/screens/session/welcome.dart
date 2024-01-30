import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: mq.height,
            width: mq.height,
            child: Image.asset('assets/background.jpeg',fit: BoxFit.fill,),
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
                  textColor: Colors.white,
                  fontSize: 45,
                ),
                HeadingTextWidget(
                  title: 'no see.',
                  textColor: Colors.white,
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
