import 'package:cloud_firestore/cloud_firestore.dart';

class BookingModel {
  final String bookingDate;
  final String fullName;
  String? id;
  String? paymentId;
  final String email;
  final String phone;
  final String completeFromAddress;
  final String completeToAddress;
  final String fromDateEpoch;
  final String toDateEpoch;
  final String fromTimeEpoch;
  final String toTimeEpoch;
  final double noOfDays;
  final String vehicleType;
  final double totalPrice;
  final bool isPickUp;
  final bool isPaid;
  final bool isDelivery;
  final bool isStandardProtection;
  final bool isLiabilityProtection;
  final bool isIHaveOwnProtection;
  final bool isCustomCoverage;
  final double totalCustomCoverage;
  final bool isUnlimitedMiles;
  final bool isUnder25years;
  final bool isReturnedDeposit;
  final bool isPromoCodeApplied;
  final double promoDiscountAmount;
  final String status;
  final String state;

  BookingModel({
    required this.bookingDate,
    required this.fullName,
    this.id = '',
    this.paymentId = '',
    required this.email,
    required this.phone,
    required this.completeFromAddress,
    required this.completeToAddress,
    required this.fromDateEpoch,
    required this.toDateEpoch,
    required this.fromTimeEpoch,
    required this.toTimeEpoch,
    required this.noOfDays,
    required this.vehicleType,
    required this.totalPrice,
    required this.isPickUp,
    required this.isPaid,
    required this.isDelivery,
    required this.isStandardProtection,
    required this.isLiabilityProtection,
    required this.isIHaveOwnProtection,
    required this.isCustomCoverage,
    required this.totalCustomCoverage,
    required this.isUnlimitedMiles,
    required this.isUnder25years,
    required this.isReturnedDeposit,
    required this.isPromoCodeApplied,
    required this.promoDiscountAmount,
    required this.status,
    required this.state,
  });

  toJson() {
    return {
      'id': id,
      'paymentId': paymentId,
      'bookingDate': bookingDate,
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'completeFromAddress': completeFromAddress,
      'completeToAddress': completeToAddress,
      'fromDateEpoch': fromDateEpoch,
      'toDateEpoch': toDateEpoch,
      'fromTimeEpoch': fromTimeEpoch,
      'toTimeEpoch': toTimeEpoch,
      'noOfDays': noOfDays,
      'vehicleType': vehicleType,
      'totalPrice': totalPrice,
      'isPickUp': isPickUp,
      'isPaid': isPaid,
      'isDelivery': isDelivery,
      'isStandardProtection': isStandardProtection,
      'isLiabilityProtection': isLiabilityProtection,
      'isIHaveOwnProtection': isIHaveOwnProtection,
      'isCustomCoverage': isCustomCoverage,
      'totalCustomCoverage': totalCustomCoverage,
      'isUnlimitedMiles': isUnlimitedMiles,
      'isUnder25years': isUnder25years,
      'isReturnedDeposit': isReturnedDeposit,
      'isPromoCodeApplied': isPromoCodeApplied,
      'promoDiscountAmount': promoDiscountAmount,
      'status': status,
      'state':state,
    };
  }

  factory BookingModel.fromJson(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final json = snapshot.data()!;
    return BookingModel(
      id: json["id"],
      paymentId: json["paymentId"],
      fullName: json["fullName"],
      bookingDate: json["bookingDate  "],
      email: json["email"],
      phone: json['phone'],
      completeFromAddress: json['completeFromAddress'],
      completeToAddress: json['completeToAddress'],
      fromDateEpoch: json['fromDateEpoch'],
      toDateEpoch: json['toDateEpoch'],
      fromTimeEpoch: json['fromTimeEpoch'],
      toTimeEpoch: json['toTimeEpoch'],
      noOfDays: json['noOfDays'],
      vehicleType: json['vehicleType'],
      totalPrice: json['totalPrice'],
      isPickUp: json['isPickUp'],
      isPaid: json['isPaid'],
      isDelivery: json['isDelivery'],
      isStandardProtection: json['isStandardProtection'],
      isLiabilityProtection: json['isLiabilityProtection'],
      isIHaveOwnProtection: json['isIHaveOwnProtection'],
      isCustomCoverage: json['isCustomCoverage'],
      totalCustomCoverage: json['totalCustomCoverage'],
      isUnlimitedMiles: json['isUnlimitedMiles'],
      isUnder25years: json['isUnder25years'],
      isReturnedDeposit: json['isReturnedDeposit'],
      isPromoCodeApplied: json['isPromoCodeApplied'],
      promoDiscountAmount: json['promoDiscountAmount'],
      status: json['status'],
      state: json['state'],
    );
  }
}
