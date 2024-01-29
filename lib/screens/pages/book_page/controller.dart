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

  state.searchLoading.value==true;
  var response = await http.get(Uri.parse(request)).then((response){
    if (response.statusCode == 200) {
      List predictions = jsonDecode(response.body.toString())['predictions'];
      List bostonPredictions = predictions.where((prediction) {
        return prediction['description'].toLowerCase().contains('boston');
      }).toList();

      state.results.value = bostonPredictions.length;
      cont.state.placeList.value =
          cont.state.placeList.value = bostonPredictions;
      state.searchLoading.value==false;
    }else{
      state.searchLoading.value = false;
    }
  }).onError((error, stackTrace){
    state.searchLoading.value==true;
  });


}

 void GetCoordinates(BuildContext context)async{
  List<Location> coordinates = await locationFromAddress(state.selectedPlace.toString());
  if(coordinates.isNotEmpty){
    final lat = coordinates.first;
    state.loc.value = LatLng(lat.latitude, lat.longitude);
    animationOfCamera(state.loc.value);

  }
 }

 void animationOfCamera(LatLng val){
   state.mapController?.animateCamera(
     CameraUpdate.newCameraPosition(CameraPosition(target: val,zoom: 12,),),
   );
   update();
 }

void GetCoordinatesofReturn(BuildContext context)async{
  List<Location> coordinates = await locationFromAddress(state.returnPlace.toString());
  if(coordinates.isNotEmpty){
    final lat = coordinates.first;
    state.returnLoc.value = LatLng(lat.latitude, lat.longitude);

  }
}


}