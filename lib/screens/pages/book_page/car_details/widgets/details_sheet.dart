import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:yb_ride/components/heading_text_widget.dart';
import 'package:yb_ride/components/reuseable_button.dart';
import 'package:yb_ride/components/text_widget.dart';
import 'package:yb_ride/helper/app_colors.dart';
import 'package:yb_ride/screens/pages/book_page/widget/2nd_bottom_sheet.dart';
import 'package:yb_ride/screens/pages/book_page/controller.dart';
import 'package:yb_ride/screens/pages/book_page/widget/3rd_bottom_sheet.dart';
import 'package:yb_ride/screens/pages/book_page/widget/date_selection_bottom.dart';

import '../../../../../main.dart';


Future detailsBottomSheet(BuildContext context) {
  final scrollController = ScrollController();
  return showModalBottomSheet(
    // backgroundColor: Theme.of(context).scaffoldBgClr,
    context: context,
    // isScrollControlled: true,
    builder: (BuildContext context) {
      return Builder(builder: (BuildContext innerContext) {
        return SingleChildScrollView(
          // physics: ClampingScrollPhysics(),
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
                  offset: Offset(0,
                      -3), // Offset in the negative y-axis to create a top shadow
                ),
              ],
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
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: HeadingTextWidget(
                      title: "Details", fontWeight: FontWeight.bold,textColor: Theme.of(context).headingColor,),
                ),
                Divider(),
                SizedBox(
                  height: mq.height * 0.025,
                ),
                _buildDetailItem(FontAwesomeIcons.person, '5 seats', context),

                _buildDetailItem(FontAwesomeIcons.suitcase, '4 suitcase(s)', context),

                _buildDetailItem(FontAwesomeIcons.gasPump, 'Gas', context),

                Divider(),
                _buildDetailItem(FontAwesomeIcons.wifi, 'Automatic transmission', context),
                _buildDetailItem(FontAwesomeIcons.snowflake, 'A/C', context),
                _buildDetailItem(FontAwesomeIcons.bluetooth, 'Bluetooth', context),
                SizedBox(
                  height: 10,
                ),

              ],
            ),
          ),
        );
      });
    },
  );
}

Widget _buildDetailItem(IconData icon, String text,BuildContext context) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: mq.width * .03 , vertical: mq.height *.01),
    child: Row(
      children: [
        Icon(icon,size: 18,),
        SizedBox(
          width: 15,
        ),
        HeadingTextWidget(title: text , textColor: Theme.of(context).headingColor,fontWeight: FontWeight.w600,),
      ],
    ),
  );
}
