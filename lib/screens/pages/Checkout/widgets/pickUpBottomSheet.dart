import 'package:flutter/material.dart';
import 'package:yb_ride/components/heading_text_widget.dart';
import 'package:yb_ride/components/reuseable_button.dart';
import 'package:yb_ride/components/text_widget.dart';
import 'package:yb_ride/screens/pages/Checkout/controller.dart';

import '../../../../main.dart';

Future pickUpBottomSheet(BuildContext context, CheckOutCon cont) async {
  return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            // height: mq.height / 2,
            decoration: BoxDecoration(
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
                      -3), // Offset in the negative y-axis to create a top shadow
                ),
              ],
              color: Theme.of(context).scaffoldBgClr,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.horizontal_rule,
                      size: 40,
                      color: Theme.of(context).lightTextColor,
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: HeadingTextWidget(
                    title: "Where & When", fontWeight: FontWeight.w600,textColor: Theme.of(context).headingColor,),
                ),
                Divider(),
                SizedBox(
                  height: mq.height * 0.015,
                ),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal : mq.width * .04),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: mq.height /4.5,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30),),
                        ),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset('assets/appImages/boston.png',fit: BoxFit.cover,)),
                      ),
                      SizedBox(height: 10,),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 5,),
                           HeadingTextWidget(title: 'Pick up at our Boston lot'),
                            SubHeadingTextWidget(title: 'We will meet you at our lot,${cont.state.pickupLoc}'),
                          ],
                        ),
                      ),
          
                    ],
                  ),
                ),
                RoundButton(title: 'Confirm Location', onPress: (){
                  Navigator.pop(context);
                }),
                SizedBox(height: 5,),
              ],
            )
          ),
        );
      });
}
