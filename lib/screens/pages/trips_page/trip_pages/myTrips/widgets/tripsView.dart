import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:yb_ride/api/api.dart';
import 'package:yb_ride/components/custom_Appbar.dart';
import 'package:yb_ride/helper/session_controller.dart';
import 'package:yb_ride/main.dart';
import 'package:yb_ride/screens/pages/trips_page/controller.dart';
import 'package:yb_ride/screens/pages/trips_page/trip_pages/myTrips/controller.dart';

class BookingDetailsScreen extends StatelessWidget {
  final String docId;

  BookingDetailsScreen({required this.docId});



  @override
  Widget build(BuildContext context) {
    final controller = MyTripController();
    Widget _buildDetailRow(String label, String value) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                color: Theme.of(context).headingColor, // You can adjust the color here
                fontWeight: FontWeight.bold,
              ),
            ),
            // SizedBox(width: 20,),
            Spacer(),
            Flexible(
              child: Text(
                value,
                style: TextStyle(
                  color: Theme.of(context).headingColor,
                ),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ),

          ],
        ),
      );
    }
    return Scaffold(
      appBar: CustomAppBarWidget(
        centerTitle: 'Booking Details', isLeading: true,
        leadingIcon: Icons.arrow_back_ios,
        leadingPress: (){
          Navigator.pop(context);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder(
          stream:APis.db.collection('all_bookings').where('bookingDate',isEqualTo: docId).snapshots(),
            builder: (context ,  snapshot){
              if(!snapshot.hasData){
                return Center(
                  child: Container(
                    height: 100,
                    width: 100,
                    child: Lottie.asset('assets/lottie/loading2.json'),
                  ),
                );
              }
              var data = snapshot.data!;

              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index){
                    String totalAmount = double.parse((data.docs[index]['totalPrice']).toString()).toStringAsFixed(2);
                    return Column(
                      children: [
                        _buildDetailRow('Name', data.docs[index]['fullName']),
                        _buildDetailRow('Email', data.docs[index]['email']),
                        _buildDetailRow('Phone Number', data.docs[index]['phone']),
                        _buildDetailRow('From Address', data.docs[index]['completeFromAddress']),
                        _buildDetailRow('To Address', data.docs[index]['completeToAddress']),
                        _buildDetailRow('Booking Date', controller.convertDate(data.docs[index]['bookingDate'])),
                        _buildDetailRow('Trip Start Date', controller.convertDate(data.docs[index]['fromDateEpoch'])),
                        _buildDetailRow('Trip End Date', controller.convertDate(data.docs[index]['toDateEpoch'])),
                        _buildDetailRow('Trip Start Time', controller.convertMillisecondsToTimeString(data.docs[index]['fromTimeEpoch'])),
                        _buildDetailRow('Trip End Time', controller.convertMillisecondsToTimeString(data.docs[index]['toTimeEpoch'])),
                        _buildDetailRow('Is Pickup', (data.docs[index]['isPickUp']).toString()),
                        _buildDetailRow('Is Delivery', (data.docs[index]['isDelivery']).toString()),
                        _buildDetailRow('Is Unlimited Miles', (data.docs[index]['isUnlimitedMiles']).toString()),
                        _buildDetailRow('Is Under 25 years', (data.docs[index]['isUnder25years']).toString()),
                        _buildDetailRow('Is Standard Protection', (data.docs[index]['isStandardProtection']).toString()),
                        _buildDetailRow('Is Liability Protection', (data.docs[index]['isLiabilityProtection']).toString()),
                        _buildDetailRow('Is Custom Coverage', (data.docs[index]['isCustomCoverage']).toString()),
                        _buildDetailRow('Is Have Own Protection', (data.docs[index]['isIHaveOwnProtection']).toString()),
                        _buildDetailRow('Promo Discount', (data.docs[index]['promoDiscountAmount']).toString()),
                        _buildDetailRow('Vehicle Type', data.docs[index]['vehicleType']),
                        _buildDetailRow('Total Price', totalAmount),
                        _buildDetailRow('Status ', (data.docs[index]['status']).toString()),
                      ],
                    );

              });
            }

        ),
      ),
    );
  }
}

// _buildDetailRow('Name', bookingDetails['name']),
// _buildDetailRow('Email', bookingDetails['email']),
// _buildDetailRow('Phone Number', bookingDetails['phoneNumber']),
// _buildDetailRow('From Address', bookingDetails['fromAddress']),
// _buildDetailRow('To Address', bookingDetails['toAddress']),
// _buildDetailRow('Booking Date', bookingDetails['bookingDate']),
// _buildDetailRow('Trip Start Date', bookingDetails['tripStartDate']),
// _buildDetailRow('Trip End Date', bookingDetails['tripEndDate']),
// _buildDetailRow('Trip Start Time', bookingDetails['tripStartTime']),
// _buildDetailRow('Trip End Time', bookingDetails['tripEndTime']),
// _buildDetailRow('Is Pickup', bookingDetails['isPickup'].toString()),
// _buildDetailRow('Is Delivery', bookingDetails['isDelivery'].toString()),
// _buildDetailRow('Is Unlimited Miles', bookingDetails['isUnlimitedMiles'].toString()),
// _buildDetailRow('Is Under 25 years', bookingDetails['isUnder25years'].toString()),
// _buildDetailRow('Is Standard Protection', bookingDetails['isStandardProtection'].toString()),
// _buildDetailRow('Is Liability Protection', bookingDetails['isLiabilityProtection'].toString()),
// _buildDetailRow('Is Custom Coverage', bookingDetails['isCustomCoverage'].toString()),
// _buildDetailRow('Is Have Own Protection', bookingDetails['isHaveOwnProtection'].toString()),
// _buildDetailRow('Promo Discount', bookingDetails['promoDiscount']),
// _buildDetailRow('Vehicle Type', bookingDetails['vehicleType']),
// _buildDetailRow('Total Price', bookingDetails['totalPrice']),