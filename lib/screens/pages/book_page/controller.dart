import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:yb_ride/helper/app_constants.dart';
import 'package:yb_ride/screens/pages/book_page/inded.dart';
import 'package:http/http.dart' as http;

class BookViewController extends GetxController {
  final state = BookNowState();

  void getCurrentDate(){
    DateTime currentDate = DateTime.now();
    // Format the date as MMDDYYYY
    String formattedDateDay = DateFormat('dd').format(currentDate);
    String formattedDateMonth = DateFormat('MM').format(currentDate);
    String formattedDateYear = DateFormat('yy').format(currentDate);
    state.fromDate.value = formattedDateDay;
    state.fromDateName.value = getDayOfWeek(currentDate);
    state.fromMonth.value = formattedDateMonth;
    state.fromMonthName.value = getMonthName(formattedDateMonth);
    state.fromYear.value = formattedDateYear;
    getLaterDate();
  }

  void getLaterDate(){
    // Get the current date
    DateTime currentDate = DateTime.now();

    // Add 5 days to the current date
    DateTime newDate = currentDate.add(Duration(days: 5));


    String formattedDateDay = DateFormat('dd').format(newDate);
    String formattedDateMonth = DateFormat('MM').format(newDate);
    String formattedDateYear = DateFormat('yy').format(newDate);

    // Print the result
    state.toDateName.value = getDayOfWeek(newDate);
    state.toDate.value = formattedDateDay;
    state.toMonth.value = formattedDateMonth;
    state.toMonthName.value = getMonthName(formattedDateMonth);
    state.toYear.value = formattedDateYear;
    state.datesFetched = true;
  }




  void getSuggestions(
      String input, dynamic sessionToken, BookViewController cont) async {
    String baseURL = AppConstants.placesBaseUrl;
    String kPLACES_API_KEY = AppConstants.kPlacesApiKey;
    String request =
        '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$sessionToken';

    state.searchLoading.value == true;
    var response = await http.get(Uri.parse(request)).then((response) {
      if (response.statusCode == 200) {
        List predictions = jsonDecode(response.body.toString())['predictions'];
        List bostonPredictions = predictions.where((prediction) {
          return prediction['description'].toLowerCase().contains('boston');
        }).toList();

        state.results.value = bostonPredictions.length;
        cont.state.placeList.value =
            cont.state.placeList.value = bostonPredictions;
        state.searchLoading.value == false;
      } else {
        state.searchLoading.value = false;
      }
    }).onError((error, stackTrace) {
      state.searchLoading.value == true;
    });
  }

  void GetCoordinates(BuildContext context) async {
    List<Location> coordinates =
        await locationFromAddress(state.selectedPlace.toString());
    if (coordinates.isNotEmpty) {
      final lat = coordinates.first;
      state.loc.value = LatLng(lat.latitude, lat.longitude);
      animationOfCamera(state.loc.value);
    }
  }

  void animationOfCamera(LatLng val) {
    state.mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: val,
          zoom: 12,
        ),
      ),
    );
    update();
  }

  void GetCoordinatesofReturn(BuildContext context) async {
    List<Location> coordinates =
        await locationFromAddress(state.returnPlace.toString());
    if (coordinates.isNotEmpty) {
      final lat = coordinates.first;
      state.returnLoc.value = LatLng(lat.latitude, lat.longitude);
    }
  }

  void extractStartEndDate(String output) {
    // Find the index of "startDate" and extract the substring
    int startIndex = output.indexOf("startDate:");
    int endIndex = output.indexOf(",", startIndex);

    // Check if "startDate" is found
    if (startIndex != -1 && endIndex != -1) {
      String startDate =
          output.substring(startIndex + "startDate:".length, endIndex).trim();
      String formattedStartDate = startDate.split(' ')[0];

      DateTime startDateDay = DateTime.parse(formattedStartDate);
      String day = getDayOfWeek(startDateDay);
      String formattedDateDay = DateFormat('dd').format(startDateDay);
      String formattedDateMonth = DateFormat('MM').format(startDateDay);
      String formattedDateYear = DateFormat('yy').format(startDateDay);



      state.fromDate.value = formattedDateDay;
      state.fromDateName.value = day;
      state.fromMonth.value = formattedDateMonth;
      state.fromMonthName.value = getMonthName(formattedDateMonth);
      state.fromYear.value = formattedDateYear;




      // Find the index of "endDate" and extract the substring
      startIndex = output.indexOf("endDate:");
      endIndex = output.indexOf(")", startIndex);

      // Check if "endDate" is found
      if (startIndex != -1 && endIndex != -1) {
        String endDate =
            output.substring(startIndex + "endDate:".length, endIndex).trim();
        String formattedEndDate = endDate.split(' ')[0];
        if (formattedEndDate != "null") {
          DateTime EndDateDay = DateTime.parse(formattedEndDate);
          String day = getDayOfWeek(EndDateDay);

          String formattedDateDay = DateFormat('dd').format(EndDateDay);
          String formattedDateMonth = DateFormat('MM').format(EndDateDay);
          String formattedDateYear = DateFormat('yy').format(EndDateDay);

          state.toDate.value = formattedDateDay;
          state.toDateName.value = day;
          state.toMonth.value = formattedDateMonth;
          state.toMonthName.value = getMonthName(formattedDateMonth);
          state.toYear.value = formattedDateYear;
          state.startEndDateSelected.value=true;


        }
      }


      // print("------------");
      // print(state.fromDate.value);
      // print(state.fromDateName.value);
      // print(state.fromMonth.value);
      // print(state.fromMonthName.value);
      // print(state.fromYear.value);
      // print("============");
      // print(state.toDate.value);
      // print(state.toDateName.value);
      // print(state.toMonth.value);
      // print(state.toMonthName.value);
      // print(state.toYear.value);

    }
  }

  String getDayOfWeek(DateTime date) {
    switch (date.weekday) {
      case DateTime.monday:
        return "Mon";
      case DateTime.tuesday:
        return "Tue";
      case DateTime.wednesday:
        return "Wed";
      case DateTime.thursday:
        return "Thu";
      case DateTime.friday:
        return "Fri";
      case DateTime.saturday:
        return "Sat";
      case DateTime.sunday:
        return "Sun";
      default:
        return "Invalid day";
    }
  }

  String getMonthName(String mon){
    // Assuming you have the month as a numerical string "01"
    String monthString = mon;

    // Convert the numerical month to an integer
    int month = int.parse(monthString);

    // Use the intl package to get the abbreviated month name
    String monthName = DateFormat('MMM').format(DateTime(2022, month, 1));

    return monthName;


  }
}
