import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';
import 'package:yb_ride/components/heading_text_widget.dart';
import 'package:yb_ride/components/reuseable_button.dart';
import 'package:yb_ride/components/text_form_field.dart';
import 'package:yb_ride/components/text_widget.dart';
import 'package:yb_ride/helper/app_colors.dart';
import 'package:http/http.dart' as http;
import 'package:yb_ride/screens/settings/pages/faqs/getting_started,dart.dart';

import '../../../../main.dart';

Future faqBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (BuildContext context) {
      return Stack(
        children: [
          Container(
            height: mq.height * .17,
            decoration: BoxDecoration(
              color: AppColors.buttonColor,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: mq.height * .02, vertical: mq.height * .02),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      HeadingTextWidget(
                        title: 'Help',
                        textColor: Colors.white,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: FaIcon(
                          FontAwesomeIcons.xmark,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    // controller: ,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.search,
                    style: GoogleFonts.openSans(
                      fontSize: 15,
                    ),

                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white.withOpacity(.3),
                      isDense: true,
                      hintText: 'Search for help',
                      suffixIcon: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      hintStyle: GoogleFonts.openSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      enabled: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: mq.height * .18,
                ),
                _buildListTile('Getting Started', '5 articles', () {
                  Get.to(
                    gettingStartedSheet(context),
                  );
                }, context),
                Divider(),
                _buildListTile('Booking Changes & Cancellation', '4 articles',
                    () {}, context),
                Divider(),
                _buildListTile(
                    'Delivery & Return', '29 articles', () {}, context),
                Divider(),
                _buildListTile('Deposits, Charges, Payments & Referrals',
                    '11 articles', () {}, context),
                Divider(),
                _buildListTile(
                    'Electric Vehicles (EV)', '13 articles', () {}, context),
                Divider(),
                _buildListTile('Insurance, Accidents & Incidents',
                    '20 articles', () {}, context),
                Divider(),
                _buildListTile(
                    'Self-Pickup and Return', '12 articles', () {}, context),
                Divider(),
                _buildListTile(
                    'Vehicles & Equipment', '6 articles', () {}, context),
                Divider(),
                _buildListTile('Verification & Driver Requirements',
                    '8 articles', () {}, context),
                Divider(),
              ],
            ),
          ),
        ],
      );
    },
  );
}

Widget _buildListTile(
    String title, String subTitle, VoidCallback onPress, BuildContext context) {
  return InkWell(
    onTap: onPress,
    child: ListTile(
      title: HeadingTextWidget(
        title: title,
        textColor: Theme.of(context).headingColor,
        fontSize: 16,
      ),
      subtitle: SubHeadingTextWidget(
        title: subTitle,
        textColor: Theme.of(context).lightTextColor,
        fontSize: 15,
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 12,
      ),
    ),
  );
}
