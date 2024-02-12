import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:yb_ride/components/heading_text_widget.dart';
import 'package:yb_ride/components/text_widget.dart';
import 'package:yb_ride/screens/pages/help_page/widgets/howCanEditMyTripBottomSheet.dart';
import 'package:yb_ride/screens/pages/help_page/widgets/sendUsMessageAlertBox.dart';
import 'package:yb_ride/screens/pages/help_page/widgets/whereIsMySurferBottomSheet.dart';
import '../../../components/reuseable_chatbot.dart';
import '../../../helper/app_colors.dart';
import '../../../main.dart';
import '../../settings/pages/faqs/view.dart';
import 'controller.dart';

class HelpScreen extends GetView<HelpCon> {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller.fetchContactDetails();
    mq = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBgClr,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            height: mq.height * .1,
            color: Colors.white, // Top color
          ),
          Container(
            height: mq.height * 0.35,
            decoration: BoxDecoration(
                color: AppColors.buttonColor,
                border: Border(
                  bottom: BorderSide(
                    color: Colors.white,
                    width: 1.0,
                  ),
                )),
            child: Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: mq.width * .09),
                      child: Image.asset(
                        "assets/images/ybRide.jpg",
                        width: mq.width * .20,
                        height: mq.height * .20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: mq.height * .01,
          ),
          Positioned(
            top: mq.height*.17,
            left:mq.width*.10,
            child: HeadingTextWidget(title: 'Hi,',textColor: AppColors.orangeColor,fontSize: 25,),
          ),
          SizedBox(
            height: mq.height * .01,
          ),
          Positioned(
            top: mq.height*.21,
            left:mq.width*.10,
            child: HeadingTextWidget(title: 'How can we help?',textColor: Colors.white,fontSize: 25,),
          ),
          SizedBox(
            height: mq.height * .02,
          ),
          Padding(
            padding: EdgeInsets.only(top: mq.height * .10),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  SizedBox(
                    height: mq.height * .15,
                  ),
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardBgClr,
                      border: Border.all(
                          color: AppColors.dotColor
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black54.withOpacity(.1),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        children: [
                          SizedBox(height: mq.height * .002),
                          InkWell(
                            onTap: (){
                              Get.to(()=>ReUseAbleChatBot());
                            },
                            child: ReuseableRow(
                              title: 'Messages',
                              textSize: 14,
                              fontWeight: FontWeight.w500,
                              iconData: Icons.message,

                              iconColor: AppColors.buttonColor,

                            ),
                          ),
                          Divider(),
                          InkWell(
                            onTap: (){
                              Get.to(()=>FAQScreen());
                            },
                            child: ReuseableRow(
                              title: 'Help',
                              textSize: 14,
                              fontWeight: FontWeight.w500,
                              iconData: Icons.question_mark,
                              iconColor: AppColors.buttonColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: mq.height * .02),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardBgClr,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: AppColors.dotColor

                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black54.withOpacity(.1),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: InkWell(
                      onTap: (){
                        sendUsMessageAlertDialog(context);
                      },
                      child: ListTile(
                        title: HeadingTextWidget(
                          title: 'Send us a message',
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          textColor: Theme.of(context).headingColor,
                        ),
                        subtitle: SubHeadingTextWidget(
                          title: "We'll be back online in 30 minutes",
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textColor: Theme.of(context).lightTextColor,
                        ),
                        trailing: Icon(
                          Icons.navigate_next,
                          color: AppColors.buttonColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: mq.height * .02),
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardBgClr,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: AppColors.dotColor
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black54.withOpacity(.1),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        children: [
                          SizedBox(height: mq.height * .002),
                          InkWell(
                            onTap: (){
                              Get.to(()=>FAQScreen());
                            },
                            child: ReuseableRow(
                              textSize: 15,
                              title: 'Search for help',
                              fontWeight: FontWeight.w500,
                              iconData: Icons.search_outlined,
                              iconColor: AppColors.buttonColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: mq.height * .02),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardBgClr,
                      border: Border.all(
                          color: AppColors.dotColor
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black54.withOpacity(.1),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: InkWell(
                      onTap: (){
                        WhereIsMySurferBottomSheet(context);
                      },
                      child: ListTile(
                        title: HeadingTextWidget(
                          title: 'Where is my Buddy?',
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          textColor: Theme.of(context).headingColor,
                        ),
                        subtitle: Padding(
                          padding:  EdgeInsets.only(top: mq.height*.006),
                          child: SubHeadingTextWidget(
                            title:
                                "When your Buddy starts their trip,you'll be able to see their...",
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            maxLines: 2,
                            textColor: Theme.of(context).lightTextColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: mq.height * .02),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardBgClr,
                      border: Border.all(
                          color: AppColors.dotColor
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black54.withOpacity(.1),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: InkWell(
                      onTap: (){
                        HowCanEditMyTripBottomSheet(context);
                      },
                      child: ListTile(
                        title: HeadingTextWidget(
                          title:
                              'How can i edit my trip? Can i extend or shorten it?',
                          maxLines: 2,
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          textColor: Theme.of(context).headingColor,
                        ),

                        subtitle: Padding(
                          padding:  EdgeInsets.only(top: mq.height*.006),
                          child: SubHeadingTextWidget(
                            title: "How to change dates, times, or address",
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            maxLines: 2,
                            textColor: Theme.of(context).lightTextColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ReuseableRow extends StatelessWidget {
  final String title;
  final Color? iconColor;
  final IconData iconData;
  final double textSize;
  final FontWeight fontWeight;
  ReuseableRow({
    Key? key,
    required this.title,
    this.iconColor,
    required this.textSize,
    required  this.fontWeight,
    required this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SubHeadingTextWidget(
          title: title,
          fontWeight: fontWeight,
          fontSize: textSize,

          textColor: Theme.of(context).headingColor,
        ),
        Icon(
          iconData,
          size: 20,
          color: iconColor,
        ),
      ],
    );
  }
}
