



import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yb_ride/components/heading_text_widget.dart';
import 'package:yb_ride/components/reuseable_button.dart';
import 'package:yb_ride/components/text_widget.dart';

import '../../../../components/reuseable_chatbot.dart';
import '../../../../main.dart';

void sendUsMessageAlertDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(0),
          child: CustomAlertDialog(),
        ),
      );
    },
  );
}

class CustomAlertDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),
      // contentPadding: EdgeInsets.symmetric(horizontal: 13,vertical: 10),
      title: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: HeadingTextWidget(title: 'Contact Us',fontSize:14,fontWeight: FontWeight.bold,),
        ),
      ),
      content: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        // height: mq.height *0.4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SectionWidget("YBRide@gmail.com."),
            SizedBox(height: mq.height*.02),
            SectionWidget( "03130228047."),
            SizedBox(height: mq.height*.02),
            RoundButton(title: 'Contact With us', onPress: (){
              Get.to(()=>ReUseAbleChatBot());
            }),
            SizedBox(height: mq.height*.001),
          ],
        ),
      ),
    );
  }
}

class SectionWidget extends StatelessWidget {
  final String text;

  SectionWidget( this.text);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Padding(
          padding:  EdgeInsets.only(top: mq.height*.015),
          child: Container(
            // height: mq.height*.005,
            width: mq.width*.009,
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.black54
            ),
          ),
        ),
        SizedBox(width: mq.width*.02),
        Expanded(child: SubHeadingTextWidget(title: text,fontSize: 16,fontWeight: FontWeight.w500,)),
      ],
    );
  }
}