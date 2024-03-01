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

Future WhereIsMySurferBottomSheet(BuildContext context) {
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
                          title: "Where is my Buddy?",
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

                        SubHeadingTextWidget(
                          textColor: Theme.of(context).headingColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          title:
                          "When your Buddy starts their trip, you'll be able to see their ETA and location in the app. if you need to call"
                              "your Buddy, you can also call the them through the app once they're on their way.",
                        ),
                        SizedBox(
                          height: mq.height * .02,
                        ),
                        SubHeadingTextWidget(
                            fontWeight: FontWeight.w500,
                            textColor: Theme.of(context).headingColor,
                            fontSize: 14,
                            title: '1. Sign into your account'),
                        SizedBox(
                          height: mq.height * .02,
                        ),
                        SubHeadingTextWidget(
                            fontWeight: FontWeight.w500,
                            textColor: Theme.of(context).headingColor,
                            fontSize: 14,
                            title: "2. Tap on 'Trips'"),
                        SizedBox(
                          height: mq.height * .02,
                        ),
                        SubHeadingTextWidget(
                            fontWeight: FontWeight.w500,
                            textColor: Theme.of(context).headingColor,
                            fontSize: 14,
                            title: "3. Tap on the trips you're interested in"),
                        SizedBox(
                          height: mq.height * .05,
                        ),
                        SubHeadingTextWidget(
                          textColor: Theme.of(context).headingColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          title:
                          "Remember that your Buddy will wait for an extra 10 minutes after the scheduled time. or 10 minutes after their"
                              "arrival time if they're running behind scheduled time!.",
                        ),
                        SizedBox(
                          height: mq.height * .03,
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.all(16.0),
                        //   child: Container(
                        //     height: mq.height * .2,
                        //     width: double.infinity,
                        //     decoration: BoxDecoration(
                        //       color: Colors.blue.withOpacity(.1),
                        //       borderRadius: BorderRadius.circular(10),
                        //     ),
                        //     child: Column(
                        //       children: [
                        //         Spacer(),
                        //         InkWell(
                        //           onTap: (){
                        //             Get.to(ReUseAbleChatBot(),);
                        //           },
                        //           child: Container(
                        //             height: 40,
                        //             width: 180,
                        //             decoration: BoxDecoration(
                        //               color: Colors.deepPurple,
                        //               borderRadius: BorderRadius.circular(10),
                        //             ),
                        //             child: Center(
                        //               child: Row(
                        //                 mainAxisAlignment: MainAxisAlignment.center,
                        //                 crossAxisAlignment: CrossAxisAlignment.center,
                        //                 children: [
                        //                   HeadingTextWidget(title: 'Ask a question' , textColor: Colors.white,fontSize: 15,),
                        //                   Icon(Icons.question_mark_outlined , color: Colors.white,size: 15,),
                        //                 ],
                        //               ),
                        //             ),
                        //           ),
                        //         ),
                        //         SizedBox(
                        //           height: mq.height * .02,
                        //         ),
                        //         SubHeadingTextWidget(title: 'The team can be helped if needed',fontWeight: FontWeight.w600,fontSize: 12,textColor: Theme.of(context).headingColor,),
                        //         SizedBox(
                        //           height: mq.height * .02,
                        //         ),
                        //         Spacer(),
                        //
                        //
                        //       ],
                        //     ),
                        //   ),
                        // ),

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
