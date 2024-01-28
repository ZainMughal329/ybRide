import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:yb_ride/helper/app_constants.dart';
import 'package:yb_ride/screens/pages/book_page/inded.dart';
import 'package:http/http.dart' as http;

class BookViewController extends GetxController {
final state = BookNowState();


void getSuggestions(
    String input, dynamic sessionToken, BookViewController cont) async {
  String baseURL = AppConstants.placesBaseUrl;
  String kPLACES_API_KEY = AppConstants.kPlacesApiKey;
  String request =
      '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$sessionToken';

  var response = await http.get(Uri.parse(request));

  if (response.statusCode == 200) {
    state.searchLoading.value = false;
    cont.state.placeList.value =
    jsonDecode(response.body.toString())['predictions'];
    // print(jsonDecode(response.body.toString())['predictions'].toString());
  }else{
    state.searchLoading.value = true;
  }
}

 void GetCoordinates(BuildContext context)async{
  List<Location> coordinates = await locationFromAddress(state.selectedPlace.toString());
  if(coordinates.isNotEmpty){
    final lat = coordinates.first;
    state.loc.value = LatLng(lat.latitude, lat.longitude);
    state.mapController?.animateCamera(
      // CameraUpdate.newLatLngZoom(state.loc.value, 15.0),
    CameraUpdate.newCameraPosition(CameraPosition(target: state.loc.value),),
    );
    // animationOfCamera(state.loc.value);
  }



 }

 void animationOfCamera(LatLng val){
  // print("animationCmaer"+val.toString());
  //  state.mapController?.animateCamera(CameraUpdate.newLatLngZoom(val, 15.0));
   // updateMarker(latLng);
 }


}