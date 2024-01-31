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

Future agePolicySheet(BuildContext context) {
  final state = CheckOutState();

  final scrollController = ScrollController();
  return showModalBottomSheet(
    isScrollControlled: true,
    useSafeArea: true,
    context: context,
    builder: (BuildContext context) {
      return Builder(builder: (BuildContext innerContext) {
        return SingleChildScrollView(
          controller: scrollController,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight:
                  mq.height * 0.9, // Set a maximum height for the bottom sheet
            ),
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
                          title: "How old do i need to be to book a YBCar?",
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
                          title: 'Age requirements for daily rentals',
                          textColor: Theme.of(context).headingColor,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 15.0),
                          child: Row(
                            children: [
                              Container(
                                height: 5,
                                width: 5,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Theme.of(context).headingColor,
                                ),
                              ),
                              SizedBox(
                                width: mq.width * .02,
                              ),
                              SubHeadingTextWidget(
                                title:
                                    'Our minimum required age in Boston is 21.',
                                textColor: Theme.of(context).headingColor,
                                fontWeight: FontWeight.w600,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: mq.height * .05,
                        ),
                        SubHeadingTextWidget(
                          textColor: Theme.of(context).headingColor,
                          fontWeight: FontWeight.w600,
                          title:
                              'Drivers under the age of 25 will be charged an additional "Young Renter Fee". The value of the fee may vary by region. The exact rate can be viewed in the price details section after selecting "I am under 25 years old" when making a booking on YBCar.',
                        ),
                        SizedBox(
                          height: mq.height * .02,
                        ),
                        SubHeadingTextWidget(
                            fontWeight: FontWeight.w600,
                            textColor: Theme.of(context).headingColor,
                            title: 'Age requirements apply to all drivers.'),

                        SizedBox(
                          height: mq.height * .05,
                        ),
                        Center(
                          child: SubHeadingTextWidget(
                              fontWeight: FontWeight.w600,
                              textColor: Theme.of(context).lightTextColor,
                              title: 'Did this answer your question?'),
                        ),

                        Container(
                          height: mq.height * .2,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Spacer(),
                              InkWell(
                                onTap: (){
                                  Get.to(ReUseAbleChatBot(),);
                                },
                                child: Container(
                                  height: 40,
                                  width: 180,
                                  decoration: BoxDecoration(
                                    color: Colors.deepPurple,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        HeadingTextWidget(title: 'Ask a question' , textColor: Colors.white,fontSize: 15,),
                                        Icon(Icons.question_mark_outlined , color: Colors.white,size: 15,),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: mq.height * .02,
                              ),
                              SubHeadingTextWidget(title: 'The team can be helped if needed',fontWeight: FontWeight.w600,fontSize: 12,textColor: Theme.of(context).headingColor,),

                              Spacer(),

                            ],
                          ),
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
