import 'package:get/get.dart';
import 'package:yb_ride/screens/settings/pages/ybcar_surfer/inded.dart';

class SurferController extends GetxController {
  final state = SurferState();


  void toggleCollapsed() {
    state.isCollapsed.value = !state.isCollapsed.value;
  }

}