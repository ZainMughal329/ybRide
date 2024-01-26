

import 'package:get/get.dart';

import 'state.dart';

class OnBoardingController extends GetxController{

  final state = OnBoardingState();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    state.index.value=0;
  }
}