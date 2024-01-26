import 'package:get/get.dart';
import 'package:yb_ride/screens/pages/book_page/controller.dart';

class BookViewBindings implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<BookViewController>(() => BookViewController());
  }

}