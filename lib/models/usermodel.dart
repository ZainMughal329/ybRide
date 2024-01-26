import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String image;
  final String name;
  String? id;
  final String email;
  final String pushToken;

  UserModel({
    required this.image,
    required this.name,
    this.id = '',
    required this.email,
    required this.pushToken,
  });

  toJson() {
    return {
      'id': id,
      'image': image,
      'name': name,
      'email': email,
      'pushToken' : pushToken,
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
    );
  }
}
