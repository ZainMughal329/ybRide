import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../helper/app_colors.dart';
import '../../../../helper/prefs.dart';

class SurferState {
  var isCollapsed = false.obs;

  RxBool focused = false.obs;
  final countryPicker =
      FlCountryCodePicker(
          searchBarTextStyle: GoogleFonts.montserrat(
            color: Pref.isDarkMode ? AppColors.whiteColor : AppColors.blackColor,
          ),
          searchBarDecoration: InputDecoration(
              suffixIcon: Icon(Icons.search),
              suffixIconColor: Pref.isDarkMode ? AppColors.whiteColor : AppColors.buttonColor,
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Pref.isDarkMode ? AppColors.whiteColor : AppColors.buttonColor,
                ),

              ),
              filled: true,
              fillColor: Pref.isDarkMode ? Colors.grey.shade900 : Colors.white
          )
      )
  ;
  final fNameCon = TextEditingController();
  final lNameCon = TextEditingController();
  final emailCon = TextEditingController();
  final phoneNumberCon = TextEditingController();

  final loading = false.obs;

  Rx<CountryCode> code =
      CountryCode(name: 'United States', code: 'US', dialCode: '+1').obs;

  Rx<String> serviceOffering = 'Select'.obs;

  RxBool requestLoading = false.obs;

}