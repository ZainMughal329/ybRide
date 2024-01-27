
import 'package:get/get.dart';

import 'controller.dart';

class InviteBindings implements Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<InviteCon>(() => InviteCon());
  }

}