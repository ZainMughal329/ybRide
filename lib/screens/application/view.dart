import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:yb_ride/helper/app_colors.dart';
import 'package:yb_ride/screens/application/controller.dart';
import 'package:yb_ride/screens/pages/book_page/inded.dart';
import 'package:yb_ride/screens/pages/help_page/inded.dart';
import 'package:yb_ride/screens/pages/invite_page/inded.dart';
import 'package:yb_ride/screens/pages/trips_page/inded.dart';
import 'package:yb_ride/screens/settings/inded.dart';
import '../../main.dart';

class ApplicationView extends GetView<ApplicationViewController> {
  const ApplicationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    var navBarItems = [
      PersistentBottomNavBarItem(
        icon: returnNavBarIcon(FontAwesomeIcons.car,context),
        title: 'Book',

        activeColorPrimary: AppColors.buttonColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
        textStyle: GoogleFonts.openSans(
            fontWeight: FontWeight.w700,
            fontSize: 12,
            color: CupertinoColors.systemGrey
        ),
      ),
      PersistentBottomNavBarItem(
        icon: returnNavBarIcon(FontAwesomeIcons.road,context),
        title: 'Trips',

        activeColorPrimary: AppColors.buttonColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
        textStyle: GoogleFonts.openSans(
            fontWeight: FontWeight.w700,
            fontSize: 12,
            color: CupertinoColors.systemGrey,
        ),

      ),
      PersistentBottomNavBarItem(
        icon: returnNavBarIcon(FontAwesomeIcons.gift,context),
        title: 'Invite',

        activeColorPrimary: AppColors.buttonColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
        textStyle: GoogleFonts.openSans(
            fontWeight: FontWeight.w700,
            fontSize: 12,
            color: CupertinoColors.systemGrey,
        ),

      ),
      PersistentBottomNavBarItem(
        icon: returnNavBarIcon(FontAwesomeIcons.solidMessage,context),
        title: 'Help',

        activeColorPrimary: AppColors.buttonColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
        textStyle: GoogleFonts.openSans(
            fontWeight: FontWeight.w700,
            fontSize: 12,
            color: CupertinoColors.systemGrey,
        ),

      ),
      PersistentBottomNavBarItem(
        icon: returnNavBarIcon(Icons.settings,context),
        title: 'Settings',
        activeColorPrimary: AppColors.buttonColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
        textStyle: GoogleFonts.openSans(
            fontWeight: FontWeight.w700,
            fontSize: 12,
            color: CupertinoColors.systemGrey,
        ),

      ),
    ];

    var navScreens = <Widget>[
      BookNowView(),
      TripScreen(),
      InviteScreen(),
      HelpScreen(),
      SettingsView(),
    ];

    return Obx( () {
      log('application:' + controller.state.currentNavIndex.value.toString());
      return PersistentTabView(

      context,
      controller: controller.perController,
      screens: navScreens,
      items: navBarItems,
      confineInSafeArea: true,
      backgroundColor: Theme.of(context).appBarColor,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: false,
      hideNavigationBarWhenKeyboardShows: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Theme.of(context).navBarColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0,-3),
          ),
        ],

      ),
      popAllScreensOnTapOfSelectedTab: true,
      itemAnimationProperties: ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.easeInOut,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style6,

    );
    });
  }
  Widget returnNavBarIcon(IconData icon,BuildContext context) {
    return Icon(
      icon,
      size: 18,
    );
  }
}