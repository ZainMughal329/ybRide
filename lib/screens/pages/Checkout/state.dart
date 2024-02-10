

import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CheckOutState{


  RxBool paymentLoading = false.obs;

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




  RxBool promoCodeapplied = false.obs;
  RxDouble promoDiscount = 0.0.obs;


  //Profile Section

  RxBool focused = false.obs;
  RxBool personalInfoAdded = false.obs;
  final countryPicker = FlCountryCodePicker();
  final fNameCon = TextEditingController();
  final lNameCon = TextEditingController();
  final emailCon = TextEditingController();
  final phoneNumberCon = TextEditingController();

  Rx<CountryCode> code =
      CountryCode(name: 'United States', code: 'US', dialCode: '+1').obs;

  List<String> economyList = [
    'assets/carImages/eco-1.png',
    'assets/carImages/eco-2.png',
    'assets/carImages/eco-3.png',
  ];

  List<String> premiumList = [
    'assets/carImages/premium-1.png',
    'assets/carImages/premium-2.png',
    'assets/carImages/premium-3.png',
  ];

  List<String> sedanList = [
    'assets/carImages/sedan-1.png',
    'assets/carImages/sedan-2.png',
    'assets/carImages/sedan-3.png',
  ];


  List<String> avdList = [
    'assets/carImages/awd-1.png',
    'assets/carImages/awd-2.png',
    'assets/carImages/awd-3.png',
  ];
  List<String> suvList = [
    'assets/carImages/7_seater-1.png',
    'assets/carImages/7_seater-2.png',
    'assets/carImages/7_seater-3.png',
  ];




}