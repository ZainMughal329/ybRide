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

Future deliveryProcessSheet(BuildContext context) {
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
                          title: "How does the delivery work?",
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
                          title: 'Updated over a week ago',
                          fontSize: 10,
                          textColor: Theme.of(context).headingColor,
                          fontWeight: FontWeight.w600,
                        ),
                        SizedBox(
                          height: mq.height * 0.03,
                        ),
                        HeadingTextWidget(
                          title: 'Pre Delivery',
                          textColor: Theme.of(context).headingColor,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SubHeadingTextWidget(
                          title:
                          "Your Buddy will pick out your cleaned car from our lot and drive it to the delivery address of your choice."
                              "Please note that while we make every effort to be punctual, there may be an arrival window of +/- 15 minutes around the scheduled time."
                          ,
                          textColor: Theme.of(context).headingColor,
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                        ),
                        SizedBox(
                          height: mq.height * .02,
                        ),
                        SubHeadingTextWidget(
                          textColor: Theme.of(context).headingColor,
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                          title:
                          "You can see your Buddy's ETA and live location in the YB-Ride app, as well as the make, model, color, and "
                              "license plate of your vehicle. If you need to contact your Buddy, you'll be able to do so through the app.",
                        ),
                        SizedBox(
                          height: mq.height * .02,
                        ),
                        SizedBox(
                          height: mq.height * 0.03,
                        ),
                        HeadingTextWidget(
                          title: 'The Handover',
                          textColor: Theme.of(context).headingColor,
                          fontWeight: FontWeight.bold,

                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SubHeadingTextWidget(
                          title:
                          "When your Buddy gets to you, they'll take photos of the vehicle and verify your driver's license. The final "
                              "step before the handover of keys is for you to sign the rental agreement. Yup, that’s really it - you're good to go!"
                          ,
                          textColor: Theme.of(context).headingColor,
                          fontWeight: FontWeight.normal,

                          fontSize: 14,
                        ),
                        SizedBox(
                          height: mq.height * 0.03,
                        ),
                        HeadingTextWidget(
                          title: 'Post Delivery',
                          textColor: Theme.of(context).headingColor,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SubHeadingTextWidget(
                          title:
                          "After the handover, we would greatly appreciate your feedback. If you were satisfied with the delivery, you"
                              "may also leave a trip for the Buddy, which will be given to them in full",
                          textColor: Theme.of(context).headingColor,
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                        ),
                        SizedBox(
                          height: mq.height * .02,
                        ),


                        SizedBox(
                          height: mq.height * .03,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(
                            height: mq.height * .15,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Center(
                                    child: SubHeadingTextWidget(title: "Pro-tip: Buddy typically only wait for 10 minutes after the scheduled time before they may need to depart for next trip -they are busy peoples!",fontWeight: FontWeight.normal,fontSize: 12,textColor: Theme.of(context).headingColor,),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: mq.height * .01,
                        ),
                        Center(child: SubHeadingTextWidget(title: 'Did this answer your question?')),
                        SizedBox(
                          height: mq.height * .01,
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
