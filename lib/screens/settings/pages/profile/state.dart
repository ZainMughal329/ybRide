

import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class profileState{
  RxBool focused = false.obs;
  final countryPicker = FlCountryCodePicker();
  final fNameCon = TextEditingController();
  final lNameCon = TextEditingController();
  final emailCon = TextEditingController();
  final phoneNumberCon = TextEditingController();
  Rx<CountryCode> code =
      CountryCode(name: 'United States', code: 'US', dialCode: '+1').obs;
}