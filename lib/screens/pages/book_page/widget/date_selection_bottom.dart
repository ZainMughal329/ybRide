import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'package:yb_ride/components/heading_text_widget.dart';
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

Future dateBottomSheet(BuildContext context, BookViewController cont) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (BuildContext context) {
      return SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
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
              Container(
                height: mq.height * 0.05,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: mq.width * 0.2,
                        child: Icon(Icons.arrow_back_ios,
                            size: 23, color: AppColors.headingColor),
                      ),
                    ),
                    Flexible(
                      child: HeadingTextWidget(
                        title: 'Delivery and return date',
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                        textColor: AppColors.headingColor,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: mq.height * 0.01),
                child: Divider(),
              ),
              Container(
                height: 800,
                child: SfDateRangePicker(
                  view: DateRangePickerView.month,
                  selectionMode: DateRangePickerSelectionMode.range,
                  minDate: DateTime(2020, 02, 05),
                  maxDate: DateTime(2020, 12, 06),
                  onSelectionChanged:
                      (DateRangePickerSelectionChangedArgs args) {
                    final dynamic value = args.value;
                  },
                  onViewChanged: (DateRangePickerViewChangedArgs args) {
                    final PickerDateRange visibleDates = args.visibleDateRange;
                    final DateRangePickerView view = args.view;
                  },
                  navigationDirection: DateRangePickerNavigationDirection.vertical,
                  navigationMode: DateRangePickerNavigationMode.scroll,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
