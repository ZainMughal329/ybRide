import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';

class BookNowState {

  final switchVal = true.obs;
  final bottomSheetIsOpen = false.obs;
  final locationSearchController = TextEditingController();
  Uuid? uuid ;
  String? sessionToken;

  RxBool searchLoading = false.obs;

  GoogleMapController? mapController;
  RxInt results = 0.obs;
  RxDouble heightOfSheet = 0.0.obs;


  //location variables
  RxList placeList = [].obs;
  RxString selectedPlace = 'Tap to Search'.obs;
  RxString returnPlace = 'Return Place'.obs;
  final loc = LatLng(42.361145, -71.057083).obs;
  final returnLoc = LatLng(0, 0).obs;
  // 42.361145, -71.057083
}