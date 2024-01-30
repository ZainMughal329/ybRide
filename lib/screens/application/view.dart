import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

class ApplicationView extends StatelessWidget {
  const ApplicationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    var navBarItems = [
      PersistentBottomNavBarItem(
        icon: returnNavBarIcon(CupertinoIcons.car_detailed,context),
        title: 'Book',
        activeColorPrimary: AppColors.buttonColor,
        inactiveColorPrimary: AppColors.buttonColor,
        textStyle: GoogleFonts.openSans(
            fontWeight: FontWeight.w700,
            fontSize: 12,
            color: AppColors.buttonColor
        ),
      ),
      PersistentBottomNavBarItem(
        icon: returnNavBarIcon(Icons.trip_origin,context),
        title: 'Trips',
        activeColorPrimary: AppColors.buttonColor,
        inactiveColorPrimary: AppColors.buttonColor,
        textStyle: GoogleFonts.openSans(
            fontWeight: FontWeight.w700,
            fontSize: 12,
            color: AppColors.buttonColor
        ),

      ),
      PersistentBottomNavBarItem(
        icon: returnNavBarIcon(Icons.card_giftcard,context),
        title: 'Invite',
        activeColorPrimary: AppColors.buttonColor,
        inactiveColorPrimary: AppColors.buttonColor,
        textStyle: GoogleFonts.openSans(
            fontWeight: FontWeight.w700,
            fontSize: 12,
            color: AppColors.buttonColor
        ),

      ),
      PersistentBottomNavBarItem(
        icon: returnNavBarIcon(Icons.help,context),
        title: 'Help',
        activeColorPrimary: AppColors.buttonColor,
        inactiveColorPrimary: AppColors.buttonColor,
        textStyle: GoogleFonts.openSans(
            fontWeight: FontWeight.w700,
            fontSize: 12,
            color: AppColors.buttonColor
        ),

      ),
      PersistentBottomNavBarItem(
        icon: returnNavBarIcon(Icons.settings,context),
        title: 'Settings',
        activeColorPrimary: AppColors.buttonColor,
        inactiveColorPrimary: AppColors.buttonColor,
        textStyle: GoogleFonts.openSans(
            fontWeight: FontWeight.w700,
            fontSize: 12,
            color: AppColors.buttonColor
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

    return PersistentTabView(
      context,
      controller: PersistentTabController(initialIndex: 4),
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
  }
  Widget returnNavBarIcon(IconData icon,BuildContext context) {
    return CircleAvatar(
      radius: 15,
      backgroundColor: Theme.of(context).appBarColor,
      child: Icon(
        icon,
        size: 18,
      ),
    );
  }
}