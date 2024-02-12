import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:yb_ride/components/heading_text_widget.dart';
import 'package:yb_ride/components/reuseable_button.dart';
import 'package:yb_ride/components/text_form_field.dart';
import 'package:yb_ride/components/text_widget.dart';
import 'package:yb_ride/helper/app_colors.dart';
import 'package:yb_ride/helper/app_constants.dart';
import 'package:yb_ride/screens/pages/Checkout/state.dart';
import '../../../../../main.dart';
Future viewInstructionsBottomSheet(BuildContext context) {
  final scrollController = ScrollController();
  return showModalBottomSheet(
    isScrollControlled: true,
    useSafeArea: true,
    context: context,
    builder: (BuildContext context) {
      return SingleChildScrollView(
        controller: scrollController,
        child: Padding(
          padding: EdgeInsets.only(bottom: 30),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5), // Shadow color
                  spreadRadius: 1, // Spread radius
                  blurRadius: 5, // Blur radius
                  offset: Offset(0,
                      -3),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.horizontal_rule,
                  size: 40,
                  color: Colors.grey.shade400,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding:  EdgeInsets.only(left: mq.width*.02),
                      child: IconButton(
                        icon: Icon(FontAwesomeIcons.xmark),
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the bottom sheet
                        },
                      ),
                    ),

                  ],
                ),
                HeadingTextWidget(
                  title: "Self-Pickup Instructions for Boston", fontWeight: FontWeight.bold,textColor: Theme.of(context).headingColor,
                  fontSize: 17,
                ),
                SizedBox(
                  height: mq.height*.01,
                ),
                Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        SubHeadingTextWidget(title: 'Updated over a week ago',fontSize: 10,),
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RoundButton(title:
                  'Important: Your 2-hours PickUp Window', onPress: (){},),
                ),
                SizedBox(
                  height: mq.height*.02,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      HeadingTextWidget(title: 'Pickup Window'),
                    ],
                  ),
                ),
                // SizedBox(
                //   height: mq.height*.02,
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SubHeadingTextWidget(title: 'You can pick up your rental car at the booking start of your reservation. Earlier arrivals cannot be'
                      'accommodated. Please ensure to arrive within a 2-hour window',fontSize: 12,),
                ),
                SizedBox(
                  height: mq.height*.01,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      HeadingTextWidget(title: 'Return Grace Period'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SubHeadingTextWidget(title: 'After your designated return time you have an additional'
                      '2-hours for the return. Late arrivals are subject to fess.',fontSize: 12,),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      HeadingTextWidget(title: 'Operational Hours'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: SubHeadingTextWidget(title: 'We are open from 7AM to 10 PM'
                      'Any arrivals outside of these hours cannot be accommodated',fontSize: 12,),
                ),
                SizedBox(
                  height: mq.height*.01,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RoundButton(title:
                  'Arrives at Our Lot', onPress: (){},),
                ),
                SizedBox(
                  height: mq.height*.02,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: SubHeadingTextWidget(title: 'The entrance is located on ${AppConstants.pickUpLoc}.',fontSize: 12,fontWeight: FontWeight.bold,),
                ),
                SizedBox(
                  height: mq.height*.02,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: SubHeadingTextWidget(title: '1. Upon arrivals, please proceed to the cashiers lobby on the right',fontSize: 12,),
                ),
                SizedBox(
                  height: mq.height*.02,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: SubHeadingTextWidget(title: '2. Spot the YbRide sign and check in by scanning the QR code displayed',fontSize: 12,),
                ),
                SizedBox(
                  height: mq.height*.02,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: SubHeadingTextWidget(title: '3. your Buddy will take photos of you car and verify your drivers license etc',fontSize: 12,),
                ),

                SizedBox(
                  height: mq.height*.01,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RoundButton(title:
                  'Returning Your Vehicle', onPress: (){},),
                ),
                SizedBox(
                  height: mq.height*.02,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: SubHeadingTextWidget(title: 'The entrance is located on ${AppConstants.pickUpLoc}.',fontSize: 12,fontWeight: FontWeight.bold,),
                ),
                SizedBox(
                  height: mq.height*.02,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: SubHeadingTextWidget(title: '1. Drive through the entrance of the garage.Please pull a ticket and place it on your dashboard',fontSize: 12,),
                ),
                SizedBox(
                  height: mq.height*.02,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: SubHeadingTextWidget(title: '2. Once you have entered the garage, please keep right and follow the YBRide signs as you proceed down to floor 3',fontSize: 12,),
                ),
                SizedBox(
                  height: mq.height*.02,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: SubHeadingTextWidget(title: '3. Once you are on P3, turn to the right and park in one of the spaces immediately to your right facing the map',fontSize: 12,),
                ),
                SizedBox(
                  height: mq.height*.02,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: SubHeadingTextWidget(title: '4.Your check-in will notify your Buddy,who will meet you to facilitate the key handover process. you will have to hand over the keys in person and cannot leave it in the vehicle',fontSize: 12,),
                ),
                SizedBox(
                  height: mq.height*.02,
                ),



              ],
            ),
          ),
        ),
      );
    },
  );
}

