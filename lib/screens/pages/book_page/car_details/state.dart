import 'package:yb_ride/api/api.dart';

class CarDetailsState {

   double rentPerDay = 23.99;

  String fromHours='';
  String fromMinutes='';
  String toHours='';
  String toMinutes='';

  final vehicleRef = APis.db.collection('vehicleData').snapshots();

}