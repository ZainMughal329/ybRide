import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:yb_ride/components/reuseable_button.dart';
import 'package:yb_ride/components/text_form_field.dart';
import 'package:yb_ride/screens/settings/pages/profile/inded.dart';

import '../../../../components/custom_Appbar.dart';
import '../../../../components/phone_number_input_field.dart';
import '../../../../main.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProfileController());
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(mq.height * .08),
        child: CustomAppBarWidget(
          centerTitle: 'Profile',
          isLeading: true,
          leadingIcon: Icons.arrow_back_ios_new,
          trailingIcon: Icons.delete,
          leadingPress: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: mq.width * .02, vertical: mq.height * .02),
          child: Column(
            children: [
              ReuseableTextField(
                  contr: controller.state.fNameCon,
                  label: "First Name",
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  obsecure: false),
              ReuseableTextField(
                  contr: controller.state.lNameCon,
                  label: "Last Name",
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  obsecure: false),
              ReuseableTextField(
                  contr: controller.state.emailCon,
                  label: "E-mail",
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  obsecure: false),
              Obx(
                () => PhoneNumberField(
                    controller.state.code.value,
                    () async {
                      final code = await controller.state.countryPicker
                          .showPicker(context: context);
                      // Null check
                      if (code != null) {
                        controller.state.code.value = code;
                      }
                      ;
                    },
                    controller.state.phoneNumberCon,
                    controller.state.focused.value,
                    () {
                      controller.state.focused.value = !controller.state.focused.value;
                    },context),
              ),
              Spacer(),
              RoundButton(title: 'Save', onPress: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
