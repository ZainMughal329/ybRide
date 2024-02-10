import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String image;
  final String name;
  String? id;
  final String email;
  final String pushToken;
  final String dateTime;
  String? refCode;
  final List<String> list;
  final List<String> referralList;
  double referralDiscount;

  UserModel({
    required this.image,
    required this.name,
    this.id = '',
    required this.email,
    required this.pushToken,
    required this.dateTime,
    this.refCode='',
     required this.list,
    required this.referralList,
    this.referralDiscount=0

  });

  toJson() {
    return {
      'id': id,
      'image': image,
      'name': name,
      'email': email,
      'pushToken' : pushToken,
      'dateTime':dateTime,
      'refCode':refCode,
      'listOfCodes' : list,
      'referralList' : referralList,
      'referralDiscount' : referralDiscount,
    };
  }

  factory UserModel.fromJson(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      ) {
    final json = snapshot.data()!;
    return UserModel(
      id: json["id"],
      name: json["name"],
      image: json["image"],
      email: json["email"],
      pushToken : json['pushToken'],
      dateTime : json['dateTime'],
      refCode : json['refCode'],
      list : json['listOfCodes'],
      referralList : json['referralList'],
      referralDiscount : json['referralDiscount'],
    );
  }
}
