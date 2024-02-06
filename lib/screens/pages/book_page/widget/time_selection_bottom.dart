import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';
import 'package:yb_ride/components/heading_text_widget.dart';
import 'package:yb_ride/components/icon_container.dart';
import 'package:yb_ride/components/reuseable_button.dart';
import 'package:yb_ride/components/text_form_field.dart';
import 'package:yb_ride/components/text_widget.dart';
import 'package:yb_ride/helper/app_colors.dart';
import 'package:yb_ride/helper/app_constants.dart';
import 'package:yb_ride/helper/app_helpers.dart';
import 'package:yb_ride/screens/pages/book_page/controller.dart';
import 'package:yb_ride/screens/pages/book_page/widget/serach_text_field.dart';
import 'package:http/http.dart' as http;

import '../../../../main.dart';

Future timeSelBottomSheet(
    BuildContext context, BookViewController cont, bool isStartTime) {
  return showModalBottomSheet(
    context: context,
    // isScrollControlled: true,
    // useSafeArea: true,
    backgroundColor: Theme.of(context).scaffoldBgClr,
    builder: (BuildContext context) {
      return Container(
        height: 200,
        width: double.infinity,
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
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.horizontal_rule,
                  size: 40,
                  color: Colors.grey.shade400,
                ),
              ],
            ),
            Container(
              height: mq.height * 0.07,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: mq.width * 0.05,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: Container(
                            // width: mq.width * 0.2,
                            child: IconContainer(iconName: 'XMark.png',height: 15,width: 15,),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: mq.width*0.1,),
                  HeadingTextWidget(
                    title:
                        isStartTime ? 'Select Start Time' : 'Select End Time',
                    fontWeight: FontWeight.w600,
                    fontSize: 19,
                    textColor: Theme.of(context).headingColor,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: mq.height * 0.01),
              child: Divider(),
            ),
            Obx((){
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HeadingTextWidget(
                        title: isStartTime
                            ? cont.state.fromTime.value
                            : cont.state.toTime.value,

                      textColor: Theme.of(context).headingColor,
                    ),
                    DropdownButton(
                      borderRadius: BorderRadius.all(Radius.circular(10),),
                      style: GoogleFonts.openSans(
                        color: Theme.of(context).headingColor,
                      ),
                      hint: isStartTime
                          ? Text('${cont.state.fromTime.value}')
                          : Text('${cont.state.toTime.value}'),
                        items: cont.state.items,
                        onChanged: (value) {
                        cont.convertTimeEpoch(value);
                          isStartTime
                              ? cont.state.fromTime.value = value
                              : cont.state.toTime.value= value;
                        },),
                  ],
                ),
              );
            }),
          ],
        ),
      );
    },
  );
}
