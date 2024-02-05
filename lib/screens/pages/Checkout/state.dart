

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CheckOutState{


  var isContainerVisible = true.obs;
  final promoCodeCon= TextEditingController();

  // extras section
  final extraSwitchVal = false.obs;
  // bottom sheet
  final buttonVisible = false.obs;
//    driverSections
  final driversCheckBoxVal = false.obs;
//    total price
RxDouble totalPrice = 0.0.obs;
  // Getting the vehicle delivery

  final vehicle_delivery = false.obs;
  final vehicle_pickup = false.obs;
  //  Coverage section
  final standard_protection =false.obs;
  final essential_protection=false.obs;
  final i_have_own=false.obs;

  // Custom Coverage
  final customValueSelected = false.obs;
  final customCoverage = false.obs;
  final cdwSwitchVal = false.obs;
  final rcliSwitchVal = false.obs;
  final sliSwitchVal = false.obs;
  final assistanceVal = false.obs;


  double? carRent;

  RxString cardNumber = "".obs;
  RxString expNumber = "".obs;
  RxString cvvNumber = "".obs;
  RxString zipCode = "".obs;
  RxString cardType = "".obs;
  RxBool cardAdded= false.obs;

  RxBool cardLoading = false.obs;

  TextEditingController cardNumController =TextEditingController();
  TextEditingController expiryController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  TextEditingController zipController = TextEditingController();


  // Firebase payment values
  RxBool dataLoaded = false.obs;
  double? delivery;
  double? essential ;
  double? standard ;
  double? CDW ;
  double? RCLI ;
  double? SLI ;
  double? assistance;
  double? licenseFee ;
  double? unlimitedMiles ;
  String? pickupLoc;

  RxBool promoCodeapplied = false.obs;
  RxDouble promoDiscount = 0.0.obs;






}