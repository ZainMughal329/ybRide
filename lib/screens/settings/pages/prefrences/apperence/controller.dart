import 'package:get/get.dart';
import 'package:yb_ride/screens/settings/pages/prefrences/apperence/inded.dart';

import '../../../../../helper/app_theme.dart';

class AppearanceController extends GetxController {
  final state = AppearanceState();
  Rx<AppTheme> currentTheme = AppTheme.System.obs;

  void setTheme(AppTheme theme) {
  currentTheme.value = theme;
  update();

  }
}