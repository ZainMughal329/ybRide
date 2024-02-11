import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:yb_ride/components/heading_text_widget.dart';
import 'package:yb_ride/components/reuseable_button.dart';
import 'package:yb_ride/components/text_form_field.dart';
import 'package:yb_ride/components/text_widget.dart';
import 'package:yb_ride/helper/app_colors.dart';
import 'package:yb_ride/screens/pages/Checkout/state.dart';
import '../../../../../main.dart';
import '../../../../components/reuseable_chatbot.dart';

Future HowCanEditMyTripBottomSheet(BuildContext context) {
  final state = CheckOutState();
  final scrollController = ScrollController();
  return showModalBottomSheet(
    isScrollControlled: true,
    useSafeArea: true,
    context: context,
    builder: (BuildContext context) {
      return Builder(builder: (BuildContext innerContext) {
        return Padding(
          padding: EdgeInsets.only(bottom: 30),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBgClr,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5), // Shadow color
                    spreadRadius: 1, // Spread radius
                    blurRadius: 5, // Blur radius
                    offset: Offset(0, -3),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        right: mq.width * .04, top: mq.height * .02),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          FontAwesomeIcons.xmark,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: mq.width * .05, vertical: mq.height * .02),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HeadingTextWidget(
                          title: "How can I edit my trip?"
                              "Can I extend or shorten it?",
                          fontWeight: FontWeight.bold,
                          textColor: Theme.of(context).headingColor,
                          // maxLines: 2,
                          fontSize: 27,
                          height: 1.25,
                        ),
                        SizedBox(
                          height: 10,
                        ),

                        SubHeadingTextWidget(
                          title: 'How to change dates, times, or address',
                          fontSize: 10,
                          textColor: Theme.of(context).headingColor,
                          fontWeight: FontWeight.w600,
                        ),

                        SizedBox(
                          height: 10,
                        ),
                        SubHeadingTextWidget(
                          title: 'Updated over a week ago',
                          fontSize: 8,
                          textColor: Theme.of(context).headingColor,
                          fontWeight: FontWeight.w600,
                        ),
                        SizedBox(
                          height: mq.height * 0.03,
                        ),

                        SubHeadingTextWidget(
                          textColor: Theme.of(context).headingColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          title:
                          "Need to change your trip dates, times, or address? No problem,"
                              "you can do it through our app or on our Website!. Just follow the steps",
                        ),
                        SizedBox(
                          height: mq.height * .02,
                        ),
                        SubHeadingTextWidget(
                            fontWeight: FontWeight.w500,
                            textColor: Theme.of(context).headingColor,
                            fontSize: 14,
                            title: '1. Sign into your account through app or website'),
                        SizedBox(
                          height: mq.height * .02,
                        ),
                        SubHeadingTextWidget(
                            fontWeight: FontWeight.w500,
                            textColor: Theme.of(context).headingColor,
                            fontSize: 14,
                            title: "2. Go to 'Trips'"),
                        SizedBox(
                          height: mq.height * .02,
                        ),
                        SubHeadingTextWidget(
                            fontWeight: FontWeight.w500,
                            textColor: Theme.of(context).headingColor,
                            fontSize: 14,
                            title: "3. Tap on the trips you'd like to edit."),
                        SizedBox(
                          height: mq.height * .02,
                        ),
                        SubHeadingTextWidget(
                            fontWeight: FontWeight.w500,
                            textColor: Theme.of(context).headingColor,
                            fontSize: 14,
                            title: "4. Tap 'Edit' in the Where and When section."),
                        SizedBox(
                          height: mq.height * .02,
                        ),
                        SubHeadingTextWidget(
                            fontWeight: FontWeight.w500,
                            textColor: Theme.of(context).headingColor,
                            fontSize: 14,
                            title: "5. Just Change the trip details and press the confirm button."),
                        SizedBox(
                          height: mq.height * .05,
                        ),
                        HeadingTextWidget(title: 'Refund Policy for Shortened Trips',fontWeight: FontWeight.bold,fontSize: 14,),
                        SizedBox(
                          height: mq.height * .05,
                        ),
                        SubHeadingTextWidget(
                          textColor: Theme.of(context).headingColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          title:
                          ". Trips shortened 48 hours prior to the scheduled delivery time are eligible for a refund for the unused days issued back to the "
                              "original payment method.",
                        ),
                        SizedBox(
                          height: mq.height * .05,
                        ),
                        SubHeadingTextWidget(
                          textColor: Theme.of(context).headingColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          title:
                          ". Trips shortened within 48 hours of the scheduled delivery time or during an ongoing trip will receive a refund in the form of YBRide credits which can be used toward fuel/toll charges, or future rentals "

                        ),
                        SizedBox(
                          height: mq.height * .03,
                        ),


                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      });
    },
  );
}
