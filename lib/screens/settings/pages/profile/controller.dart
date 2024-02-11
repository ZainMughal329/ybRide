

import 'package:get/get.dart';
import 'package:yb_ride/screens/settings/pages/profile/index.dart';

class ProfileController extends GetxController{
  final state = profileState();
  void onFocusChange(bool value) {
    state.focused.value = value;
  }
}