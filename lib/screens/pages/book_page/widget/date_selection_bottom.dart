import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'package:yb_ride/components/heading_text_widget.dart';
import 'package:yb_ride/components/reuseable_button.dart';
import 'package:yb_ride/components/snackbar_widget.dart';
import 'package:yb_ride/components/text_form_field.dart';
import 'package:yb_ride/components/text_widget.dart';
import 'package:yb_ride/helper/app_colors.dart';

import 'package:yb_ride/screens/pages/book_page/controller.dart';
import 'package:yb_ride/screens/pages/book_page/widget/serach_text_field.dart';
import 'package:http/http.dart' as http;
import 'package:yb_ride/screens/pages/book_page/widget/time_selection_bottom.dart';

import '../../../../main.dart';

Future dateBottomSheet(BuildContext context, BookViewController cont) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Theme.of(context).scaffoldBgClr,
    useSafeArea: true,
    builder: (BuildContext context) {
      return Stack(
        children: [
          SingleChildScrollView(
            child: Container(
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
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.horizontal_rule,
                          size: 40,
                          color: Colors.grey.shade400,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                  Container(
                    height: mq.height * 0.04,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: mq.width * 0.2,
                            child: Icon(Icons.arrow_back_ios,
                                size: 23, color: Theme.of(context).headingColor),
                          ),
                        ),
                        HeadingTextWidget(
                          title: 'Delivery and return date',
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          textColor: Theme.of(context).headingColor,
                        ),
                        Spacer(
                          flex: 1,
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
                      minDate: DateTime(
                          2024, int.parse("${cont.state.fromMonth.value}"), 01),
                      maxDate: DateTime(2029, 12, 31),
                      todayHighlightColor: AppColors.buttonColor,
                      viewSpacing: 5,
                      headerStyle: DateRangePickerHeaderStyle(
                        textStyle:
                            GoogleFonts.openSans(fontWeight: FontWeight.w600),
                      ),
                      monthViewSettings: DateRangePickerMonthViewSettings(
                        // viewHeaderHeight: 50,
                        showTrailingAndLeadingDates: false,
                        dayFormat: 'EEE',
                        viewHeaderStyle: DateRangePickerViewHeaderStyle(
                          textStyle:
                              GoogleFonts.openSans(fontWeight: FontWeight.w700),
                        ),
                      ),
                      monthCellStyle: DateRangePickerMonthCellStyle(
                        cellDecoration: BoxDecoration(),
                        textStyle:
                            GoogleFonts.openSans(fontWeight: FontWeight.w500),
                      ),
                      yearCellStyle: DateRangePickerYearCellStyle(
                        textStyle:
                            GoogleFonts.openSans(fontWeight: FontWeight.w500),
                      ),
                      onSelectionChanged:
                          (DateRangePickerSelectionChangedArgs args) {
                        final dynamic value = args.value;
                        cont.extractStartEndDate(args.value.toString());
                      },
                      onViewChanged: (DateRangePickerViewChangedArgs args) {
                        final PickerDateRange visibleDates =
                            args.visibleDateRange;
                        final DateRangePickerView view = args.view;
                      },
                      navigationDirection:
                          DateRangePickerNavigationDirection.vertical,
                      navigationMode: DateRangePickerNavigationMode.scroll,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: mq.height * 0.2,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBgClr,
                border: Border.all(
                  color: AppColors.buttonColor,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            timeSelBottomSheet(context, cont, true);
                          },
                          child: Container(
                            child: Column(
                              children: [
                                Obx(() {
                                  return SubHeadingTextWidget(
                                    title:
                                        "${cont.state.fromDateName.value} ${cont.state.fromMonthName.value} ${cont.state.fromDate.value} 20${cont.state.fromYear.value}",
                                    textColor: Theme.of(context).headingColor,
                                    fontWeight: FontWeight.w600,
                                  );
                                }),
                                Obx((){
                                  return SubHeadingTextWidget(
                                    textColor: Theme.of(context).lightTextColor,
                                      title: '${cont.state.fromTime.value}',);
                                }),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: mq.width * 0.05),
                          child: Container(
                            height: mq.height * 0.06,
                            width: 2,
                            color: AppColors.dotColor,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            timeSelBottomSheet(context, cont, false);
                          },
                          child: Container(
                            child: Column(
                              children: [
                                Obx(() {
                                  return SubHeadingTextWidget(
                                      title:
                                          "${cont.state.toDateName.value} ${cont.state.toMonthName.value} ${cont.state.toDate.value} 20${cont.state.toYear.value}",
                                      textColor: Theme.of(context).headingColor,
                                      fontWeight: FontWeight.w600);
                                }),
                                Obx((){
                                  return SubHeadingTextWidget(
                                      title: '${cont.state.toTime.value}',textColor: Theme.of(context).lightTextColor,);
                                }),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  RoundButton(title: "Choose date & time", onPress: () {

                    if(cont.state.startEndDateSelected.value == true
                    ){
                      cont.state.timeandDateSelected.value = true;
                      Navigator.pop(context);
                    }else{
                      Snackbar.showSnackBar("Error","Select Date & Time", Icons.error_outline_outlined);
                    }


                  }),
                ],
              ),
            ),
          ),
        ],
      );
    },
  );
}
