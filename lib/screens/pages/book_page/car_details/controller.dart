import 'package:get/get.dart';
import 'package:yb_ride/api/api.dart';
import 'package:yb_ride/helper/session_controller.dart';
import 'package:yb_ride/helper/shared_pref.dart';
import 'package:yb_ride/routes/routes_name.dart';
import 'package:yb_ride/screens/pages/book_page/car_details/inded.dart';

class CarDetailsController extends GetxController {
  final state = CarDetailsState();

  List<String> imagesList = [
    'assets/images/01.png',
    'assets/images/2.png',
    'assets/images/3.png',
    'assets/images/4.jpeg',
  ];
}
