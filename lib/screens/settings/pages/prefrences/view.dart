import 'dart:developer';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:yb_ride/components/heading_text_widget.dart';
import 'package:yb_ride/components/reuseable_button.dart';
import 'package:yb_ride/components/text_form_field.dart';
import 'package:yb_ride/components/text_widget.dart';
import 'package:yb_ride/screens/settings/pages/prefrences/apperence/inded.dart';
import 'package:yb_ride/screens/settings/pages/prefrences/controller.dart';
import 'package:yb_ride/screens/settings/pages/profile/inded.dart';

import '../../../../components/custom_Appbar.dart';
import '../../../../components/phone_number_input_field.dart';
import '../../../../helper/app_colors.dart';
import '../../../../main.dart';

class PreferenceScreen extends GetView<PreferenceController> {
  const PreferenceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(PreferenceController());
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(mq.height * .08),
        child: CustomAppBarWidget(
          centerTitle: 'Preferences',
          isLeading: true,
          leadingIcon: Icons.arrow_back_ios_new,
          leadingPress: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: mq.width * .04, vertical: mq.height * .04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                  onTap: () {
                    PersistentNavBarNavigator.pushNewScreen(context,
                        screen: AppearanceScreen(), withNavBar: true);
                  },
                  child: Container(
                      width: double.infinity,
                      child: _buildTile('Appearance', 'Yes, we have a dark theme',context))),
              SizedBox(
                height: mq.height * .03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildTile('SMS notifications', 'For chat and trips updates',context),
                  Obx(
                    () => _switchButtonWithOutAppSettings(
                      controller.state.smsSwitchVal.value,
                      (value) {
                        controller.state.smsSwitchVal.value = value;
                      },

                    ),
                  ),
                ],
              ),
              SizedBox(
                height: mq.height * .03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildTile(
                      'Push notifications', 'For chat and trips updates',context),
                  Obx(
                    () => _switchButtonWithAppSettings(
                      controller.state.notificationSwitchVal.value,
                      (value) {
                        controller.state.notificationSwitchVal.value = value;
                      },

                    ),
                  ),
                ],
              ),
              SizedBox(
                height: mq.height * .03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildTile('Location', 'For a better booking experience',context),
                  Obx(
                    () => _switchButtonWithAppSettings(
                        controller.state.locationSwitchVal.value, (value) {
                      controller.state.locationSwitchVal.value = value;
                    },
                  ),),
                ],
                  ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTile(String title, String subTitle,BuildContext context) {
    return Column(

      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeadingTextWidget(title: title,textColor: Theme.of(context).headingColor),
        SizedBox(
          height: mq.height * .01,
        ),
        SubHeadingTextWidget(
          title: subTitle,
          textColor: Theme.of(context).lightTextColor,
          fontWeight: FontWeight.w600,
        ),
      ],
    );
  }

  Widget _switchButtonWithAppSettings(
      bool val, ValueChanged<bool>? onChanged) {
    return Switch(

      activeColor: AppColors.whiteColor,
      activeTrackColor: AppColors.buttonColor,
      value: val,
      onChanged:  (value) {
        onChanged?.call(value);
          AppSettings.openAppSettings();

      },
    );
  }


  Widget _switchButtonWithOutAppSettings(
      bool val, ValueChanged<bool>? onChanged) {
    return Switch(

      activeColor: AppColors.whiteColor,
      activeTrackColor: AppColors.buttonColor,
      value: val,
      onChanged:  onChanged,
    );
  }
}
