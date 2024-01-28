// theme_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:yb_ride/components/text_widget.dart';
import 'package:yb_ride/helper/app_colors.dart';
import 'package:yb_ride/screens/settings/pages/prefrences/apperence/controller.dart';

import '../../../../../components/custom_Appbar.dart';
import '../../../../../helper/app_theme.dart';
import '../../../../../main.dart';

class AppearanceScreen extends StatelessWidget {
  final _appearanceController = Get.put(AppearanceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(mq.height * .08),
        child: CustomAppBarWidget(centerTitle: 'Appearance', isLeading: true,
            leadingIcon: Icons.arrow_back_ios_new,
            leadingPress: () {
              Navigator.pop(context);
            }
            ,),
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: mq.width * .04, vertical: mq.height * .01),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SubHeadingTextWidget(title:'System',fontWeight: FontWeight.w600,textColor: AppColors.headingColor,),
                Obx(() => Radio(
                  value: AppTheme.System,
                  groupValue: _appearanceController.currentTheme.value,
                  onChanged: (value) {
                    _appearanceController.setTheme(value as AppTheme);
                  },
                )),

              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SubHeadingTextWidget(title:'Light',fontWeight: FontWeight.w600,textColor: AppColors.headingColor,),
                Obx(() => Radio(
                  value: AppTheme.Light,
                  groupValue: _appearanceController.currentTheme.value,
                  onChanged: (value) {
                    _appearanceController.setTheme(value as AppTheme);
                  },
                )),

              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SubHeadingTextWidget(title:'Dark',fontWeight: FontWeight.w600,textColor: AppColors.headingColor,),
                Obx(() => Radio(
                  value: AppTheme.Dark,
                  groupValue: _appearanceController.currentTheme.value,
                  onChanged: (value) {
                    _appearanceController.setTheme(value as AppTheme);
                  },
                )),

              ],
            ),


          ],
        ),
      ),
    );
  }
}
