import 'package:cloud_firestore/cloud_firestore.dart';

class CreditCardModel {
  final String number;
  final String cvv;
  String? id;
  final String expiryDate;
  final String zipCode;

  CreditCardModel({
    required this.number,
    required this.cvv,
    this.id = '',
    required this.expiryDate,
    required this.zipCode,
  });

  toJson() {
    return {
      'id': id,
      'number': number,
      'cvv': cvv,
      'expiryDate': expiryDate,
      'zipCode' : zipCode,
    };
  }

  factory CreditCardModel.fromJson(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      ) {
    final json = snapshot.data()!;
    return CreditCardModel(
      id: json["id"],
      cvv: json["cvv"],
      number: json["number"],
      expiryDate: json["expiryDate"],
      zipCode : json['zipCode'],
    );
  }
}
