import 'package:get/get.dart';
import 'package:yb_ride/screens/application/controller.dart';
import 'package:yb_ride/screens/pages/book_page/controller.dart';
import 'package:yb_ride/screens/pages/help_page/bindings.dart';
import 'package:yb_ride/screens/pages/invite_page/controller.dart';
import 'package:yb_ride/screens/settings/controller.dart';


import '../pages/trips_page/controller.dart';

class ApplicationViewBindings implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<ApplicationViewController>(() => ApplicationViewController());
    Get.lazyPut<BookViewController>(()=>BookViewController());
    Get.lazyPut<TripController>(() => TripController());
    Get.lazyPut<SettingsController>(() => SettingsController());
    Get.lazyPut<InviteCon>(() => InviteCon());
    Get.lazyPut<HelpBindings>(() => HelpBindings());

  }

}