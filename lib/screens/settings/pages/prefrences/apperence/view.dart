// theme_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:yb_ride/components/text_widget.dart';
import 'package:yb_ride/helper/app_colors.dart';
import 'package:yb_ride/screens/settings/pages/prefrences/apperence/controller.dart';

import '../../../../../components/custom_Appbar.dart';
import '../../../../../helper/app_theme.dart';
import '../../../../../helper/prefs.dart';
import '../../../../../main.dart';

class AppearanceScreen extends StatelessWidget {
  final _appearanceController = Get.put(AppearanceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBgClr,

      appBar: PreferredSize(
        preferredSize: Size.fromHeight(mq.height * .08),
        child: CustomAppBarWidget(
          centerTitle: 'Appearance',
          isLeading: true,
          leadingIcon: Icons.arrow_back_ios_new,
          leadingPress: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: mq.width * .04, vertical: mq.height * .04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                Get.changeThemeMode(_appearanceController.state.isDarkMode.value
                    ? ThemeMode.light
                    : ThemeMode.dark);

                _appearanceController.state.isDarkMode.value =
                    !_appearanceController.state.isDarkMode.value;
                Pref.isDarkMode = _appearanceController.state.isDarkMode.value;
                isDarkTheme = Theme.of(context).brightness == Brightness.dark;
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.brightness_4_outlined),
                      SizedBox(
                        width: mq.width * .015,
                      ),
                      SubHeadingTextWidget(
                        title: 'Light',
                        fontWeight: FontWeight.w600,
                        textColor: Theme.of(context).headingColor,
                      ),
                    ],
                  ),
                  Obx(
                    () => _appearanceController.state.isDarkMode.value == false
                        ? Icon(
                            Icons.done,
                            size: 26,
                          )
                        : Container(),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: mq.height * .04,
            ),
            InkWell(
              onTap: () {
                Get.changeThemeMode(_appearanceController.state.isDarkMode.value
                    ? ThemeMode.light
                    : ThemeMode.dark);

                _appearanceController.state.isDarkMode.value =
                    !_appearanceController.state.isDarkMode.value;
                Pref.isDarkMode = _appearanceController.state.isDarkMode.value;
                isDarkTheme = Theme.of(context).brightness == Brightness.dark;
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.brightness_2_outlined),
                      SizedBox(
                        width: mq.width * .015,
                      ),
                      SubHeadingTextWidget(
                        title: 'Dark',
                        fontWeight: FontWeight.w600,
                        textColor: Theme.of(context).headingColor,
                      ),
                    ],
                  ),
                  Obx(
                    () => _appearanceController.state.isDarkMode.value
                        ? Icon(
                            Icons.done,
                            size: 26,
                          )
                        : Container(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
