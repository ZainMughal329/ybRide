import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yb_ride/components/heading_text_widget.dart';
import 'package:yb_ride/components/reuseable_button.dart';
import 'package:yb_ride/components/snackbar_widget.dart';
import 'package:yb_ride/components/text_form_field.dart';
import 'package:yb_ride/components/text_widget.dart';
import 'package:yb_ride/helper/app_colors.dart';
import 'package:yb_ride/screens/session/login/controller.dart';

import '../../../main.dart';
import '../../../routes/routes_name.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller.fetchUserCollectionData();
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBgClr,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: mq.height * 0.15,
            ),
            Center(
              child: Container(
                height: mq.height * 0.2,
                width: mq.height * 0.2,
                // color: Colors.black54,
                child: Image.asset('assets/appImages/circleLogo.png'),
              ),
            ),
            SizedBox(
              height: mq.height * 0.05,
            ),
            ReuseableTextField(
                contr: controller.state.emailCon,
                label: 'Email',
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                obsecure: false),
            SizedBox(
              height: mq.height * .0005,
            ),
           Obx(() =>  ReuseableTextField(
               contr: controller.state.passCon,
               label: 'Password',
               textInputAction: TextInputAction.done,
               keyboardType: TextInputType.visiblePassword,
               useEmailValidation: true,
               obsecure: controller.state.isObscure.value)),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("Hide Password"),
                SizedBox(width: 3,),
                Obx(() => Checkbox(value: controller.state.isObscure.value,
                  onChanged: (val){
                    controller.state.isObscure.value = val!;
                  },
                )),
                SizedBox(width: 3,),
              ],
            ),
            // SizedBox(
            //   height: mq.height * .01,
            // ),
            // Padding(
            //   padding: EdgeInsets.only(right: mq.width * 0.06),
            //   child: Align(
            //     alignment: Alignment.bottomRight,
            //     child: HeadingTextWidget(
            //       title: 'Forgot Password?',
            //       decoration: TextDecoration.underline,
            //       decorationColor: AppColors.buttonColor,
            //       fontSize: 12,
            //       textColor: AppColors.buttonColor,
            //     ),
            //   ),
            // ),
            SizedBox(
              height: mq.height * .02,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: mq.width * 0.06),
              child: RoundButton(
                title: 'Login',
                onPress: () {
                    controller.loginUserWithEmailAndPassword(
                        controller.state.emailCon.text.trim().toString(),
                        controller.state.passCon.text.trim().toString(),
                        context);

                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SubHeadingTextWidget(
                  title: 'Don\'t have an account?',
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  textColor: Theme.of(context).lightTextColor,
                ),
                InkWell(
                  onTap: () {
                    Get.offNamed(RoutesName.signUpScreen);
                  },
                  child: HeadingTextWidget(
                    title: 'SignUp',
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.buttonColor,
                    fontSize: 10,
                    textColor: AppColors.buttonColor,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: mq.height * .01,
            ),
            Platform.isAndroid
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: mq.width * 0.05),
                    child: Row(
                      children: [
                        Expanded(child: Divider()),
                        SubHeadingTextWidget(
                          title: ' or ',
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          textColor: Theme.of(context).lightTextColor,
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),
                  )
                : Container(),
            SizedBox(
              height: mq.height * .01,
            ),
            Platform.isAndroid
                ? Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 10, horizontal: mq.width * .1),
                    child: InkWell(
                      onTap: () {
                        controller.handleGoogleSignIn(context);
                      },
                      child: Container(
                        height: mq.height * .06,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: AppColors.buttonColor,
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.g_mobiledata,
                                color: AppColors.buttonTextColor,
                              ),
                              Text(
                                'Sign in with google',
                                style: GoogleFonts.openSans(
                                    color: AppColors.buttonTextColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
