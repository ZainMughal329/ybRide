import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yb_ride/api/api.dart';
import 'package:yb_ride/components/reuseable_button.dart';
import 'package:yb_ride/components/text_form_field.dart';
import 'package:yb_ride/routes/routes_name.dart';
import 'package:yb_ride/screens/session/signUp/controller.dart';

import '../../../components/heading_text_widget.dart';
import '../../../components/snackbar_widget.dart';
import '../../../components/text_widget.dart';
import '../../../helper/app_colors.dart';
import '../../../helper/notification_services.dart';
import '../../../main.dart';
import '../../../models/usermodel.dart';

class SignupScreen extends GetView<SignUpController> {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).scaffoldBgClr,

      body: Padding(
        padding:  EdgeInsets.symmetric(vertical: MediaQuery.of(context).padding.bottom),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: mq.height * 0.15,
              ),
              Center(
                child: Container(
                  height: mq.height * 0.2,
                  width: mq.height * 0.2,
                  child: Image.asset('assets/appImages/circleLogo.png'),
                ),
              ),
              // Spacer(),
              SizedBox(
                height: mq.height * 0.05,
              ),
              ReuseableTextField(
                  contr: controller.state.nameCon,
                  label: 'Name',
                  inputFormatters:[FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]'))],
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  obsecure: false),
              SizedBox(
                height: mq.height * .0015,
              ),
              ReuseableTextField(
                  contr: controller.state.emailCon,
                  label: 'Email',
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  useEmailValidation: true,
                  obsecure: false),
              SizedBox(
                height: mq.height * .0015,
              ),
              ReuseableTextField(
                  contr: controller.state.refCon,
                  label: 'Referral Code (optional)',
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  obsecure: false),
              SizedBox(
                height: mq.height * .0015,
              ),
              Obx(() => ReuseableTextField(
                contr: controller.state.passCon,
                label: 'Password',
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.visiblePassword,
                obsecure:  controller.state.isObscure.value,
              )),
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
              SizedBox(
                height: mq.height * .03,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: mq.width * 0.06),
                child: RoundButton(
                    title: 'SignUp',
                    onPress: () async {
                      if (controller.state.nameCon.text.isNotEmpty &&
                          controller.state.emailCon.text.isNotEmpty &&
                          controller.state.passCon.text.isNotEmpty) {
                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                            .hasMatch(controller.state.emailCon.text)) {
                          Snackbar.showSnackBar(
                              'YB-Ride', 'Enter a valid email address',
                              Icons.error_outline);
                        } else {
                          NotificationServices services = NotificationServices();
                          late String token;
                          await services.getToken().then((value) {
                            token = value;
                          });
                          log('token:$token');
                          log('SignUp Page:object');
                          UserModel user = UserModel(
                            name: controller.state.nameCon.text.trim(),
                            image: '',
                            email: controller.state.emailCon.text.trim(),
                            pushToken: token,
                            dateTime: DateTime
                                .now()
                                .millisecondsSinceEpoch
                                .toString(),
                            refCode: controller.state.refCon.text.trim()
                                .toString(),
                            list: [],
                            referralList: [],
                          );
                          controller.storeUser(
                            user,
                            context,
                            controller.state.emailCon.text.trim(),
                            controller.state.passCon.text.trim(),
                          );
                        }
                      }else {
                        log('Signup page:Error');
                        // Snackbar.showSnackBar('Error', 'All fields must be filled',
                        //     Icons.info_outline);
                      }
                    }),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SubHeadingTextWidget(
                    title: 'Already have an account?',
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    textColor: Theme.of(context).lightTextColor,

                  ),
                  InkWell(
                    onTap: (){
                      Get.offNamed(RoutesName.loginScreen);
                    },
                    child: HeadingTextWidget(
                      title: 'Login',
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.buttonColor,
                      fontSize: 10,
                      textColor: AppColors.buttonColor,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: mq.height * 0.05,
              ),

              // Spacer(
              //     // flex: 2,
              //     ),
            ],
          ),
        ),
      ),
    );
  }
}
