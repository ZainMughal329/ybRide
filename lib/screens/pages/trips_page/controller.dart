import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yb_ride/screens/pages/trips_page/inded.dart';

class TripController extends GetxController with GetTickerProviderStateMixin {
  final state = TripState();

  late TabController tabController = TabController(length: 2, vsync: this);

}