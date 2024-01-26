import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yb_ride/components/reuseable_button.dart';
import 'package:yb_ride/components/text_form_field.dart';
import 'package:yb_ride/screens/session/signUp/controller.dart';

import '../../../main.dart';

class SignupScreen extends GetView<SignUpController> {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SignUpController());
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
              contr: controller.state.firstNameCon,
              label: 'First Name',
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              obsecure: false),
          SizedBox(
            height: mq.height * .0015,
          ),
          ReuseableTextField(
              contr: controller.state.emailCon,
              label: 'Last Name',
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
            child: RoundButton(title: 'SignUp', onPress: () {}),
          ),

          Spacer(
              // flex: 2,
              ),
        ],
      ),
    );
  }
}
