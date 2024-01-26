import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yb_ride/api/api.dart';
import 'package:yb_ride/components/reuseable_button.dart';
import 'package:yb_ride/components/text_form_field.dart';
import 'package:yb_ride/screens/session/signUp/controller.dart';

import '../../../main.dart';
import '../../../models/usermodel.dart';

class SignupScreen extends GetView<SignUpController> {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
          ReuseableTextField(
              contr: controller.state.nameCon,
              label: 'Name',
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
              obsecure: false),
          SizedBox(
            height: mq.height * .0015,
          ),
          ReuseableTextField(
              contr: controller.state.passCon,
              label: 'Password',
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.visiblePassword,
              obsecure: true),
          SizedBox(
            height: mq.height * .03,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: mq.width * 0.06),
            child: RoundButton(
                title: 'SignUp',
                onPress: () {
                  if (controller.state.nameCon.text.isNotEmpty &&
                      controller.state.emailCon.text.isNotEmpty &&
                      controller.state.passCon.text.isNotEmpty) {
                    log('SignUp Page:object');
                    UserModel user = UserModel(
                      name: controller.state.nameCon.text.trim(),
                      image: '',
                      email: controller.state.emailCon.text.trim(),
                      pushToken: '',
                    );
                    controller.storeUser(
                      user,
                      context,
                      controller.state.emailCon.text.trim(),
                      controller.state.passCon.text.trim(),
                    );
                  } else {
                    log('Signup page:Error');
                    // Snackbar.showSnackBar('Error', 'All fields must be filled',
                    //     Icons.info_outline);
                  }
                }),
          ),
          Spacer(
              // flex: 2,
              ),
        ],
      ),
    );
  }
}
