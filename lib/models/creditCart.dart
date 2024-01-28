import 'package:cloud_firestore/cloud_firestore.dart';

class CreditCardModel {
  final String number;
  final String cvc;
  String? id;
  final String expiryDate;
  final String cardHolderName;

  CreditCardModel({
    required this.number,
    required this.cvc,
    this.id = '',
    required this.expiryDate,
    required this.cardHolderName,
  });

  toJson() {
    return {
      'id': id,
      'number': number,
      'cvc': cvc,
      'expiryDate': expiryDate,
      'zipCode' : cardHolderName,
    };
  }

  factory CreditCardModel.fromJson(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      ) {
    final json = snapshot.data()!;
    return CreditCardModel(
      id: json["id"],
      cvc: json["cvc"],
      number: json["number"],
      expiryDate: json["expiryDate"],
      cardHolderName : json['zipCode'],
    );
  }
}
