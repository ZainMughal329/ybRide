import 'package:flutter/material.dart';
import 'package:yb_ride/helper/prefs.dart';

class AppColors {
  static final Color buttonColor =  Color(0xff583d8b);
  static final Color textColor = Pref.isDarkMode ? Colors.white60 :Color(0xff606060);
  static final Color buttonTextColor = Colors.white;
  static final Color appBarColor = Pref.isDarkMode ? Colors.black :Colors.white;

  static final Color headingColor = Pref.isDarkMode ? Colors.white :Colors.black;
  static final Color iconColor = Color(0xff583d8b);
  static final Color activeTextFieldColor = Color(0xff583d8b);
  static final Color nonActiveTextFieldColor = Color(0xff606060);
  static final Color detailsIconColor = Colors.black;
  static final Color orangeColor = Color(0xfff26b35);
  static final Color promoCodeColor = Colors.yellow;
  static Color dotColor = Color(0xffafafaf);
  static final Color snackBarBgColor = Color(0xff583d8b);
  static final Color snackBarTextColor = Colors.white;
  static final Color whiteColor = Colors.white;
  static final Color blackColor = Colors.black;
  static final Color settingsIconColor = Color(0xff606060);
}
