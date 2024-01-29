import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class SurferState {
  var isCollapsed = true.obs;

  RxBool focused = false.obs;
  final countryPicker = FlCountryCodePicker();
  final fNameCon = TextEditingController();
  final lNameCon = TextEditingController();
  final emailCon = TextEditingController();
  final phoneNumberCon = TextEditingController();

  Rx<CountryCode> code =
      CountryCode(name: 'United States', code: 'US', dialCode: '+1').obs;

  Rx<String> serviceOffering = 'Select'.obs;

}