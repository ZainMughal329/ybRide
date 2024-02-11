import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:yb_ride/api/api.dart';
import 'package:yb_ride/components/snackbar_widget.dart';
import 'package:yb_ride/helper/app_constants.dart';
import 'package:yb_ride/helper/session_controller.dart';
import 'package:yb_ride/models/booking_model.dart';
import 'package:yb_ride/routes/routes_name.dart';
import 'package:yb_ride/screens/application/controller.dart';
import 'package:yb_ride/screens/application/view.dart';
import 'package:yb_ride/screens/pages/Checkout/controller.dart';

import '../../../../components/heading_text_widget.dart';

class PaymentController extends GetxController {
  final cont = CheckOutCon();

  dynamic paymentIntent;

  displayPaymentSheet(BuildContext context) async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        print(":::::::::::DisplaypaymentResponse:::::::::::");
        print(value);

        showDialog(
            context: context,
            builder: (_) => AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children:  [
                  Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 100.0,
                  ),
                  SizedBox(height: 10.0),
                  Text("Payment Successful!"),
                  SizedBox(height: 10.0),
                ],
              ),
            ));
        createBooking(context);

        paymentIntent = null;
      }).onError((error, stackTrace) {
        throw Exception(error);
      });
    } on StripeException catch (e) {
      print('Error is:---> $e');
      AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: const [
                Icon(
                  Icons.cancel,
                  color: Colors.red,
                ),
                Text("Payment Failed"),
              ],
            ),
          ],
        ),
      );
    } catch (e) {
      print('$e');
    }
  }

  createPaymentIntent(String currency,double totalAmount) async {
    try {
      //Request body
      Map<String, dynamic> body = {
        // 'amount': calculateAmount(amount),
        'amount':calculateDoubleAmount(totalAmount),
        'currency': currency,
        'receipt_email':AppConstants.custEmail.toString(),
        'description':'YB-Car rent for '+AppConstants.rentDays.toStringAsFixed(1)+' days', // The description of Payment
      };

      //Make post request to Stripe
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer ${AppConstants.stripe_secret_key}',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );
      print(":::::::::::Create Payment Intent :::::::::::::");
      final data = json.decode(response.body);
      AppConstants.paymentId = data['id'].toString();
      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future<void> makePayment(BuildContext context,double totalAmount) async {

    try {
      //STEP 1: Create Payment Intent
      paymentIntent = await createPaymentIntent('USD',totalAmount);
      //STEP 2: Initialize Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntent!['client_secret'], //Gotten from payment intent
              style: ThemeMode.light,
              merchantDisplayName: 'YB-Ride'))
          .then((value) {
      });

      //STEP 3: Display Payment sheet
      displayPaymentSheet(context);
    } catch (err) {
      throw Exception(err);
    }

  }
  calculateAmount(String amount) {
    final calculatedAmout = (int.parse(amount)) * 100;
    return calculatedAmout.toString();
  }

  String calculateDoubleAmount(double amount){
    int result = (amount * 100).round();
    return result.toString(); // Output: 16375
  }

  setPaymentLoadin(bool val){
    cont.state.paymentLoading.value=val;
  }

  Future<void> createBooking(BuildContext context) async{
    String docId = DateTime.now().millisecondsSinceEpoch.toString();
    setPaymentLoadin(true);
    BookingModel booking = BookingModel(
        id: SessionController().userId.toString(),
        paymentId: AppConstants.paymentId,
        bookingDate: docId,
        fullName: '${AppConstants.custFirstName} ${AppConstants.custLastName}',
        email: AppConstants.custEmail,
        phone: AppConstants.custPhoneNo,
        completeFromAddress: AppConstants.fromAddress.toString(),
        completeToAddress: AppConstants.toAddress.toString(),
        fromDateEpoch: AppConstants.epochFromDate.toString(),
        toDateEpoch: AppConstants.epochToDate.toString(),
        fromTimeEpoch: AppConstants.fromTimeinMiliSeconds.toString(),
        toTimeEpoch: AppConstants.toTimeinMiliSeconds.toString(),
        noOfDays: AppConstants.rentDays,
        vehicleType: AppConstants.vehicleType.toString(),
        totalPrice: AppConstants.totalAmountToPay,
        isPickUp: AppConstants.isPickup,
        isDelivery: AppConstants.isDeliver,
        isStandardProtection: AppConstants.standardProtection,
        isLiabilityProtection: AppConstants.liabilityProtection,
        isIHaveOwnProtection: AppConstants.i_have_own,
        isCustomCoverage: AppConstants.customCoverage,
        totalCustomCoverage: AppConstants.totalCustomCoverage,
        isUnlimitedMiles: AppConstants.unlimitedMiles,
        isUnder25years: AppConstants.under25Years,
        isPromoCodeApplied: AppConstants.isPromoApplied,
        promoDiscountAmount: AppConstants.promoDiscountAmount,
        status: 'pending',
    );

    try{
      await APis.db.collection('all_bookings').doc(docId).set(booking.toJson()).then((value){
        Navigator.pop(context);
        // Code to redirect to Trips Screen
        resetReferralCredit();
        setPaymentLoadin(false);
        Snackbar.showSnackBar("YB-Ride", 'Payed and Booked Successfully', Icons.done_all);
        AppConstants.resetToInitialState();
        Get.offNamed(RoutesName.applicationScreen,arguments: {
          'index':0,
        });


      }).onError((error, stackTrace){
        setPaymentLoadin(false);
        Snackbar.showSnackBar("YB-Ride", error.toString(), Icons.error_outline);
      });
    }catch(e){
      setPaymentLoadin(false);
      Snackbar.showSnackBar("YB-Ride", e.toString(), Icons.error_outline);
    }

  }


  Future<void> resetReferralCredit() async{
    await APis.db.collection('users').doc(SessionController().userId.toString()).update({
      'referralDiscount':0
    });
    }
}
