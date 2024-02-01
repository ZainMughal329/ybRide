import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:yb_ride/api/api.dart';
import 'package:yb_ride/helper/app_constants.dart';
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

  void calculateNoDays(){


    getFromHoursAndMinutes(AppConstants.fromTime);
    getToHoursAndMinutes(AppConstants.toTime);

String startDateString = '20${AppConstants.fromYear}-${AppConstants.fromMonth}-${AppConstants.fromDate}';
String endDateString = '20${AppConstants.toYear}-${AppConstants.toMonth}-${AppConstants.toDate}';
String startTimeString = '${state.fromHours}:${state.fromMinutes}:00';
String endTimeString = '${state.toHours}:${state.toHours}:00';

    // print('==========>');
    // print(AppConstants.fromTime);
    // print(AppConstants.toTime);
    // print(startTimeString);
    // print(startDateString);
    // print(endTimeString);
    // print(endDateString);
    // Parse date and time strings into DateTime objects
    DateTime startDate = parseDateTime(startDateString, startTimeString);
    DateTime endDate = parseDateTime(endDateString, endTimeString);


Duration difference = endDate.difference(startDate);
double numberOfDays = difference.inMicroseconds / Duration.microsecondsPerDay;

// print("Difference of days "+difference.toString());
   double days = double.parse(numberOfDays.toStringAsFixed(2));

AppConstants.rentDays = days;


  }
// 2012-02-27 13:27:00
  // Function to parse date and time strings and create a DateTime object
  DateTime parseDateTime(String dateString, String timeString) {
    // Combine date and time strings and parse into DateTime
    String combinedDateTimeString = '$dateString $timeString';
    return DateTime.parse(combinedDateTimeString);
  }
  void getFromHoursAndMinutes(String timeString) {
    // Split the time string by space to separate time and AM/PM
    List<String> timeParts = timeString.split(' ');

    // Extract the hours and minutes from the time part
    List<String> timeValues = timeParts[0].split(':');
    String hours = timeValues[0].toString().padLeft(2, '0');
    String minutes = timeValues[1].toString().padLeft(2, '0');

    // Adjust hours if it's PM
    if (timeParts.length > 1 && timeParts[1].toUpperCase() == "PM") {
      hours = (int.parse(hours) % 12 + 12).toString().padLeft(2, '0');
    }

    // Print the results
    // print("Hours: $hours, Minutes: $minutes");
    state.fromHours=hours.toString();
      state.fromMinutes=minutes.toString();
  }

  void getToHoursAndMinutes(String timeString) {
    // Split the time string by space to separate time and AM/PM
    List<String> timeParts = timeString.split(' ');

    // Extract the hours and minutes from the time part
    List<String> timeValues = timeParts[0].split(':');
    String hours = timeValues[0].toString().padLeft(2, '0');
    String minutes = timeValues[1].toString().padLeft(2, '0');

    // Adjust hours if it's PM
    if (timeParts.length > 1 && timeParts[1].toUpperCase() == "PM") {
      hours = (int.parse(hours) % 12 + 12).toString().padLeft(2, '0');
    }

    // Print the results
    // print("Hours: $hours, Minutes: $minutes");
    state.toHours=hours.toString();
    state.toMinutes=minutes.toString();
  }



}
