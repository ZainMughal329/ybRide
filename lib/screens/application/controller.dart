import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:yb_ride/screens/application/state.dart';

class ApplicationViewController extends GetxController {
  final state = ApplicationState();
  final perController = PersistentTabController(
  );

  void changeTab(int index) {
    perController.index = index;
  }

}