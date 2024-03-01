import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:yb_ride/helper/app_constants.dart';
import 'package:yb_ride/routes/routes_name.dart';
import 'package:yb_ride/screens/pages/book_page/car_details/inded.dart';
import 'package:yb_ride/screens/pages/book_page/inded.dart';
import 'package:http/http.dart' as http;
import 'package:yb_ride/helper/prefs.dart';

class BookViewController extends GetxController {
  final state = BookNowState();

  void getCurrentDate() {
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

  void updateMapTheme(GoogleMapController controller) {
    Pref.isDarkMode
        ? getJsonFileFromThemes("themes/night_style.json")
            .then((value) => setGoogleMapStyle(value, controller))
        : getJsonFileFromThemes("themes/standard_style.json")
            .then((value) => setGoogleMapStyle(value, controller));
  }

  Future<String> getJsonFileFromThemes(String mapStylePath) async {
    ByteData byteData = await rootBundle.load(mapStylePath);
    var list = byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
    return utf8.decode(list);
  }

  setGoogleMapStyle(String googleMapStyle, GoogleMapController controller) {
    controller.setMapStyle(googleMapStyle);
  }

  void getLaterDate() {
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

    AppConstants.toDateName = getDayOfWeek(newDate).toString();
    AppConstants.toDate = formattedDateDay;
    AppConstants.toMonth = formattedDateMonth;
    AppConstants.toMonthName = getMonthName(formattedDateMonth);
    AppConstants.toYear = formattedDateYear;
    // AppConstants.toDateName
    // AppConstants.toDateName
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
        print('predictions: ' + predictions.toString());
        List bostonPredictions = predictions.where((prediction) {
          print('inside:'+prediction.toString());
          print('virginia: ' + prediction['structured_formatting']['secondary_text'].toLowerCase());
          print('inside 121');

          return prediction['structured_formatting']['secondary_text'].toLowerCase().contains('va, usa') ||
              prediction['structured_formatting']['secondary_text'].toLowerCase().contains('ma, usa') ||
              prediction['structured_formatting']['secondary_text'].toLowerCase().contains('dc, usa') ||
              prediction['structured_formatting']['secondary_text'].toLowerCase().contains('md, usa');
        }).toList();

        state.results.value = bostonPredictions.length;
        // cont.state.placeList.value =
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
    state.startEndDateSelected.value = true;
    print(state.startEndDateSelected.value);

    // state.startEndDateSelected.value=true;
    // Find the index of "startDate" and extract the substring
    int startIndex = output.indexOf("startDate:");
    int endIndex = output.indexOf(",", startIndex);

    // state.timeandDateSelected.value=true;

    // Check if "startDate" is found
    if (startIndex != -1 && endIndex != -1) {
      String startDate =
          output.substring(startIndex + "startDate:".length, endIndex).trim();
      String formattedStartDate = startDate.split(' ')[0];

      DateTime startDateDay = DateTime.parse(formattedStartDate);
      print(formattedStartDate);
      print("milisec" + startDateDay.millisecondsSinceEpoch.toString());
      String day = getDayOfWeek(startDateDay);
      String formattedDateDay = DateFormat('dd').format(startDateDay);
      String formattedDateMonth = DateFormat('MM').format(startDateDay);
      String formattedDateYear = DateFormat('yy').format(startDateDay);

      AppConstants.epochFromDate =
          startDateDay.millisecondsSinceEpoch.toString();
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
        // added line

        if (formattedEndDate != "null") {
          print(formattedEndDate);

          DateTime EndDateDay = DateTime.parse(formattedEndDate);

          print(EndDateDay.microsecondsSinceEpoch);
          print("milisec" + EndDateDay.millisecondsSinceEpoch.toString());

          String day = getDayOfWeek(EndDateDay);

          String formattedDateDay = DateFormat('dd').format(EndDateDay);
          String formattedDateMonth = DateFormat('MM').format(EndDateDay);
          String formattedDateYear = DateFormat('yy').format(EndDateDay);

          AppConstants.epochToDate =
              EndDateDay.millisecondsSinceEpoch.toString();
          state.toDate.value = formattedDateDay;
          state.toDateName.value = day;
          state.toMonth.value = formattedDateMonth;
          state.toMonthName.value = getMonthName(formattedDateMonth);
          state.toYear.value = formattedDateYear;

          // state.startEndDateSelected.value=true;
        }
      }
    }
    state.startEndDateSelected.value = true;
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

  String getMonthName(String mon) {
    // Assuming you have the month as a numerical string "01"
    String monthString = mon;

    // Convert the numerical month to an integer
    int month = int.parse(monthString);

    // Use the intl package to get the abbreviated month name
    String monthName = DateFormat('MMM').format(DateTime(2022, month, 1));

    return monthName;
  }

  void moveToSelectVehicleScreen() {
    AppConstants.fromMonth = state.fromMonth.value;
    AppConstants.fromMonthName = state.fromMonthName.value;
    AppConstants.fromDate = state.fromDate.value;
    AppConstants.fromDateName = state.fromDateName.value;
    AppConstants.fromYear = state.fromYear.value;
    AppConstants.fromTime = state.fromTime.value;
    AppConstants.toMonth = state.toMonth.value;
    AppConstants.toMonthName = state.toMonthName.value;
    AppConstants.toDate = state.toDate.value;
    AppConstants.toDateName = state.toDateName.value;
    AppConstants.toYear = state.toYear.value;
    AppConstants.toTime = state.toTime.value;
    AppConstants.fromAddress = state.selectedPlace.value;
    AppConstants.fromTimeinMiliSeconds =
        (convertTimeEpoch(state.fromTime.value)).toString();
    AppConstants.toTimeinMiliSeconds =
        (convertTimeEpoch(state.toTime.value)).toString();
    if (state.returnPlace.value == 'Return Place') {
      AppConstants.toAddress = state.selectedPlace.value;
    } else {
      AppConstants.toAddress = state.returnPlace.value;
    }

    Get.toNamed(RoutesName.carDetailsScreen, arguments: {'isTextShow', false , 'stateName' , ''});
  }

  int convertTimeEpoch(String time) {
    String timeString = time;

    int milliseconds = getTimeInMillisecondsSinceMidnight(timeString);
    print('Milliseconds since midnight (${time}): $milliseconds');
    return milliseconds;
  }

  int getTimeInMillisecondsSinceMidnight(String timeString) {
    List<String> parts = timeString.split(' ');

    // Extract hour and minute
    List<String> timeParts = parts[0].split(':');
    int hour = int.parse(timeParts[0]);
    int minute = int.parse(timeParts[1]);

    // Adjust for PM times
    if (parts[1] == "PM" && hour != 12) {
      hour += 12;
    }
    // Adjust for midnight
    else if (parts[1] == "AM" && hour == 12) {
      hour = 0;
    }

    // Calculate the milliseconds since midnight
    int millisecondsSinceMidnight = hour * Duration.millisecondsPerHour +
        minute * Duration.millisecondsPerMinute;

    return millisecondsSinceMidnight;
  }
}
