import 'package:cloud_firestore/cloud_firestore.dart';

class DriverModel {
  final String image;
  final String name;
  final String phone;
  String? id;
  final String email;
  final String pushToken;
  final String dateTime;
  final String city;


  DriverModel({
    required this.image,
    required this.name,
    required this.phone,
    this.id = '',
    required this.email,
    required this.pushToken,
    required this.dateTime,
    required this.city,
  });

  toJson() {
    return {
    'id': id,
    'image': image,
    'phone': phone,
    'name': name,
      'email': email,
      'pushToken' : pushToken,
      'dateTime':dateTime,
      'city':city,
    };
  }

  factory DriverModel.fromJson(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      ) {
    final json = snapshot.data()!;
    return DriverModel(
      id: json["id"],
      name: json["name"],
      image: json["image"],
      phone: json["phone"],
      email: json["email"],
      pushToken : json['pushToken'],
      dateTime : json['dateTime'],
      city : json['city'],
    );
  }
}