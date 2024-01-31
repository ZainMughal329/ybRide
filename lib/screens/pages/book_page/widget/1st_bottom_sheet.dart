import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:yb_ride/components/heading_text_widget.dart';
import 'package:yb_ride/components/reuseable_button.dart';
import 'package:yb_ride/components/snackbar_widget.dart';
import 'package:yb_ride/components/text_widget.dart';
import 'package:yb_ride/helper/app_colors.dart';
import 'package:yb_ride/screens/pages/book_page/widget/2nd_bottom_sheet.dart';
import 'package:yb_ride/screens/pages/book_page/controller.dart';
import 'package:yb_ride/screens/pages/book_page/widget/3rd_bottom_sheet.dart';
import 'package:yb_ride/screens/pages/book_page/widget/date_selection_bottom.dart';

import '../../../../main.dart';

Future firstBottomSheet(BuildContext context, BookViewController con) {
  final scrollController = ScrollController();
  return showModalBottomSheet(
    isDismissible: true,
    context: context,
    // backgroundColor: Theme.of(context).scaffoldBgClr,
    builder: (BuildContext context) {
      return SingleChildScrollView(
        // reverse: false,
        physics: BouncingScrollPhysics(),
        controller: scrollController,
        child: Container(
          height: con.state.switchVal.value == false
              ? con.state.heightOfSheet.value
              : null,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBgClr,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
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
                    color: Theme.of(context).lightTextColor,
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: HeadingTextWidget(
                  title: "Where & When",
                  fontWeight: FontWeight.w600,
                  textColor: Theme.of(context).headingColor,
                ),
              ),
              Divider(),
              SizedBox(
                height: mq.height * 0.015,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  // height: mq.height * 0.15,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.buttonColor,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //
                      //code for 2nd sheet
                      ListTile(
                        onTap: () {
                          largeBottomSheet(context, con);
                        },
                        leading: Icon(Icons.location_on,
                            size: 30, color: Theme.of(context).headingColor),
                        title: HeadingTextWidget(
                          title: 'Delivery & return location',
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          textColor: AppColors.buttonColor,
                        ),
                        subtitle: Obx(() {
                          return SubHeadingTextWidget(
                            title: con.state.selectedPlace.value,
                            fontSize: 12,
                            textColor: Theme.of(context).lightTextColor,
                            fontWeight: FontWeight.w600,
                          );
                        }),
                      ),
                      Obx(() {
                        return con.state.switchVal.value == true
                            ? Container()
                            : ListTile(
                                onTap: () {
                                  // largeBottomSheet(context,con);
                                  returnBottomSheet(context, con);
                                },
                                leading: Icon(Icons.circle_outlined,
                                    size: 30,
                                    color: Theme.of(context).headingColor),
                                title: HeadingTextWidget(
                                  title: 'Return return location',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  textColor: AppColors.buttonColor,
                                ),
                                subtitle: Obx(() {
                                  return SubHeadingTextWidget(
                                    title: con.state.returnPlace.value,
                                    fontSize: 12,
                                    textColor: Theme.of(context).lightTextColor,
                                    fontWeight: FontWeight.w600,
                                  );
                                }),
                              );
                      }),
                      SizedBox(
                        height: mq.height * 0.002,
                      ),
                      Divider(),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: mq.width * 0.005),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: mq.width * 0.005,
                            ),
                            Flexible(
                              child: SubHeadingTextWidget(
                                title: 'Same delivery & return locations',
                                fontWeight: FontWeight.w600,
                                fontSize: 13.5,
                                textColor: Theme.of(context).headingColor,
                              ),
                            ),
                            Obx(
                              () {
                                return Switch(
                                  activeColor: Theme.of(context).scaffoldBgClr,
                                  activeTrackColor: AppColors.buttonColor,
                                  value: con.state.switchVal.value,
                                  onChanged: (val) {
                                    con.state.switchVal.value = val;
                                    if (val != true) {
                                      con.state.returnPlace.value =
                                          "Return Place";
                                      con.state.returnLoc.value = LatLng(0, 0);
                                    }
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: mq.height * 0.015,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  // height: mq.height * 0.15,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.buttonColor,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ListTile(
                        leading: Icon(
                          Icons.calendar_today_rounded,
                          size: 20,
                          color: Theme.of(context).headingColor,
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              // width: mq.width * 0.05,
                              child: Column(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SubHeadingTextWidget(
                                    title: 'From',
                                    fontWeight: FontWeight.w500,
                                    textAlign: TextAlign.start,
                                    textColor: AppColors.buttonColor,
                                  ),
                                  SizedBox(
                                    height: mq.height * 0.015,
                                  ),
                                  SubHeadingTextWidget(
                                    title: 'To',
                                    fontWeight: FontWeight.w500,
                                    textAlign: TextAlign.start,
                                    textColor: AppColors.buttonColor,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: mq.width * 0.035,
                            ),
                            InkWell(
                              onTap: () {
                                dateBottomSheet(context, con);
                              },
                              child: Obx(() {
                                return Container(
                                  child: Column(
                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SubHeadingTextWidget(
                                            title:
                                                '${con.state.fromMonthName.value} ${con.state.fromDate.value}, ',
                                            fontWeight: FontWeight.w500,
                                            textAlign: TextAlign.start,
                                            textColor:
                                                Theme.of(context).headingColor,
                                          ),
                                          SubHeadingTextWidget(
                                            title:
                                                '${con.state.fromTime.value}',
                                            fontWeight: FontWeight.w500,
                                            textAlign: TextAlign.start,
                                            textColor:
                                                Theme.of(context).headingColor,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: mq.height * 0.015,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SubHeadingTextWidget(
                                            title:
                                                '${con.state.toMonthName.value} ${con.state.toDate.value}, ',
                                            fontWeight: FontWeight.w500,
                                            textAlign: TextAlign.start,
                                            textColor:
                                                Theme.of(context).headingColor,
                                          ),
                                          SubHeadingTextWidget(
                                            title: '${con.state.toTime.value}',
                                            fontWeight: FontWeight.w500,
                                            textAlign: TextAlign.start,
                                            textColor:
                                                Theme.of(context).headingColor,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: mq.height * 0.002,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: mq.height * 0.015,
              ),
              RoundButton(
                title: 'Enter Location',
                onPress: () {
                  if (con.state.switchVal.value == true) {
                    if (con.state.locationSelected.value == true &&
                        con.state.timeandDateSelected.value == true) {
                      // success scenario
                      Snackbar.showSnackBar("title", "suscasd", Icons.done);
                    } else if (con.state.locationSelected.value == true &&
                        con.state.timeandDateSelected.value != true) {
                      Snackbar.showSnackBar("Error", "Select From & To Date",
                          Icons.error_outline_outlined);
                    } else if (con.state.locationSelected.value != true &&
                        con.state.timeandDateSelected.value == true) {
                      Snackbar.showSnackBar(
                          "Error",
                          "Select Delivery and Return Location",
                          Icons.error_outline_outlined);
                    } else if (con.state.locationSelected.value != true &&
                        con.state.timeandDateSelected.value != true) {
                      Snackbar.showSnackBar(
                          "Error",
                          "Select Location and Date ",
                          Icons.error_outline_outlined);
                    }
                  } else if (con.state.switchVal.value != true) {
                    if (con.state.returnPlace.value == "Return Place") {
                      Snackbar.showSnackBar("Error", "Select Return Location",
                          Icons.error_outline_outlined);
                    } else {
                      if (con.state.locationSelected.value == true &&
                          con.state.timeandDateSelected.value == true) {
                        // success scenario


                        Snackbar.showSnackBar("title", "suscasd", Icons.done);
                      } else if (con.state.locationSelected.value == true &&
                          con.state.timeandDateSelected.value != true) {
                        Snackbar.showSnackBar("Error", "Select From & To Date",
                            Icons.error_outline_outlined);
                      } else if (con.state.locationSelected.value != true &&
                          con.state.timeandDateSelected.value == true) {
                        Snackbar.showSnackBar(
                            "Error",
                            "Select Delivery and Return Location",
                            Icons.error_outline_outlined);
                      } else if (con.state.locationSelected.value != true &&
                          con.state.timeandDateSelected.value != true) {
                        Snackbar.showSnackBar(
                            "Error",
                            "Select Location and Date ",
                            Icons.error_outline_outlined);
                      }
                    }
                  }
                },
              ),
              SizedBox(
                height: mq.height * 0.015,
              ),
            ],
          ),
        ),
      );
      // return Builder(builder: (BuildContext innerContext) {
      //   con.state.heightOfSheet.value = MediaQuery.of(innerContext).size.height;
      //   return SingleChildScrollView(
      //     // reverse: false,
      //     physics: BouncingScrollPhysics(),
      //     controller: scrollController,
      //     child: Container(
      //       height: con.state.switchVal.value == false
      //           ? con.state.heightOfSheet.value
      //           : null,
      //       width: double.infinity,
      //       decoration: BoxDecoration(
      //         color: Theme.of(context).scaffoldBgClr,
      //         borderRadius: BorderRadius.only(
      //           topLeft: Radius.circular(15),
      //           topRight: Radius.circular(15),
      //         ),
      //         // boxShadow: [
      //         //   BoxShadow(
      //         //     color: Colors.black.withOpacity(0.5), // Shadow color
      //         //     spreadRadius: 1, // Spread radius
      //         //     blurRadius: 5, // Blur radius
      //         //     offset: Offset(0,
      //         //         -3), // Offset in the negative y-axis to create a top shadow
      //         //   ),
      //         // ],
      //       ),
      //       child: Column(
      //         mainAxisAlignment: MainAxisAlignment.start,
      //         children: [
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             children: [
      //               Icon(
      //                 Icons.horizontal_rule,
      //                 size: 40,
      //                 color: Theme.of(context).lightTextColor,
      //               )
      //             ],
      //           ),
      //           Padding(
      //             padding: const EdgeInsets.only(bottom: 5),
      //             child: HeadingTextWidget(
      //                 title: "Where & When", fontWeight: FontWeight.w600,textColor: Theme.of(context).headingColor,),
      //           ),
      //           Divider(),
      //           SizedBox(
      //             height: mq.height * 0.015,
      //           ),
      //           Padding(
      //             padding: EdgeInsets.symmetric(horizontal: 20),
      //             child: Container(
      //               // height: mq.height * 0.15,
      //               width: double.infinity,
      //               decoration: BoxDecoration(
      //                 border: Border.all(
      //                   color: AppColors.buttonColor,
      //                   width: 1,
      //                 ),
      //                 borderRadius: BorderRadius.all(
      //                   Radius.circular(10),
      //                 ),
      //               ),
      //               child: Column(
      //                 mainAxisAlignment: MainAxisAlignment.center,
      //                 children: [
      //                   //
      //                   //code for 2nd sheet
      //                   ListTile(
      //                     onTap: () {
      //                       largeBottomSheet(context, con);
      //                     },
      //                     leading: Icon(Icons.location_on,
      //                         size: 30, color: Theme.of(context).headingColor),
      //                     title: HeadingTextWidget(
      //                       title: 'Delivery & return location',
      //                       fontWeight: FontWeight.w600,
      //                       fontSize: 14,
      //                       textColor: AppColors.buttonColor,
      //                     ),
      //                     subtitle: Obx(() {
      //                       return SubHeadingTextWidget(
      //                         title: con.state.selectedPlace.value,
      //                         fontSize: 12,
      //                         textColor: Theme.of(context).lightTextColor,
      //                         fontWeight: FontWeight.w600,
      //                       );
      //                     }),
      //                   ),
      //                   Obx(() {
      //                     return con.state.switchVal.value == true
      //                         ? Container()
      //                         : ListTile(
      //                             onTap: () {
      //                               // largeBottomSheet(context,con);
      //                               returnBottomSheet(context, con);
      //                             },
      //                             leading: Icon(Icons.circle_outlined,
      //                                 size: 30, color: Theme.of(context).headingColor),
      //                             title: HeadingTextWidget(
      //                               title: 'Return return location',
      //                               fontWeight: FontWeight.w600,
      //                               fontSize: 14,
      //                               textColor: AppColors.buttonColor,
      //                             ),
      //                             subtitle: Obx(() {
      //                               return SubHeadingTextWidget(
      //                                 title: con.state.returnPlace.value,
      //                                 fontSize: 12,
      //                                 textColor: Theme.of(context).lightTextColor,
      //                                 fontWeight: FontWeight.w600,
      //                               );
      //                             }),
      //                           );
      //                   }),
      //                   SizedBox(
      //                     height: mq.height * 0.002,
      //                   ),
      //                   Divider(),
      //                   Padding(
      //                     padding: EdgeInsets.symmetric(
      //                         horizontal: mq.width * 0.005),
      //                     child: Row(
      //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                       children: [
      //                         SizedBox(
      //                           width: mq.width * 0.005,
      //                         ),
      //                         Flexible(
      //                           child: SubHeadingTextWidget(
      //                             title: 'Same delivery & return locations',
      //                             fontWeight: FontWeight.w600,
      //                             fontSize: 13.5,
      //                             textColor: Theme.of(context).headingColor,
      //                           ),
      //                         ),
      //                         Obx(
      //                           () {
      //                             return Switch(
      //                               activeColor: Theme.of(context).scaffoldBgClr,
      //                               activeTrackColor: AppColors.buttonColor,
      //                               value: con.state.switchVal.value,
      //                               onChanged: (val) {
      //                                 con.state.switchVal.value = val;
      //                                 if(val!=true){
      //                                   con.state.returnPlace.value = "Return Place";
      //                                   con.state.returnLoc.value = LatLng(0, 0);
      //                                 }
      //                               },
      //                             );
      //                           },
      //                         ),
      //                       ],
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //             ),
      //           ),
      //           SizedBox(
      //             height: mq.height * 0.015,
      //           ),
      //           Padding(
      //             padding: EdgeInsets.symmetric(horizontal: 20),
      //             child: Container(
      //               // height: mq.height * 0.15,
      //               width: double.infinity,
      //               decoration: BoxDecoration(
      //                 border: Border.all(
      //                   color: AppColors.buttonColor,
      //                   width: 1,
      //                 ),
      //                 borderRadius: BorderRadius.all(
      //                   Radius.circular(10),
      //                 ),
      //               ),
      //               child: Column(
      //                 mainAxisAlignment: MainAxisAlignment.center,
      //                 children: [
      //                   ListTile(
      //                     leading: Icon(
      //                       Icons.calendar_today_rounded,
      //                       size: 20,
      //                       color: Theme.of(context).headingColor,
      //                     ),
      //                     title: Row(
      //                       mainAxisAlignment: MainAxisAlignment.start,
      //                       children: [
      //                         Container(
      //                           // width: mq.width * 0.05,
      //                           child: Column(
      //                             // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                             crossAxisAlignment: CrossAxisAlignment.start,
      //                             children: [
      //                               SubHeadingTextWidget(
      //                                 title: 'From',
      //                                 fontWeight: FontWeight.w500,
      //                                 textAlign: TextAlign.start,
      //                                 textColor: AppColors.buttonColor,
      //                               ),
      //                               SizedBox(
      //                                 height: mq.height * 0.015,
      //                               ),
      //                               SubHeadingTextWidget(
      //                                 title: 'To',
      //                                 fontWeight: FontWeight.w500,
      //                                 textAlign: TextAlign.start,
      //                                 textColor: AppColors.buttonColor,
      //                               ),
      //                             ],
      //                           ),
      //                         ),
      //                         SizedBox(
      //                           width: mq.width * 0.035,
      //                         ),
      //                         InkWell(
      //                           onTap: (){
      //                             dateBottomSheet(context, con);
      //                           },
      //                           child: Obx((){
      //                             return Container(
      //                               child: Column(
      //                                 // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                                 crossAxisAlignment: CrossAxisAlignment.start,
      //                                 children: [
      //                                   Row(
      //                                     mainAxisAlignment:
      //                                     MainAxisAlignment.start,
      //                                     children: [
      //                                       SubHeadingTextWidget(
      //                                         title: '${con.state.fromMonthName.value} ${con.state.fromDate.value}, ',
      //                                         fontWeight: FontWeight.w500,
      //                                         textAlign: TextAlign.start,
      //                                         textColor: Theme.of(context).headingColor,
      //                                       ),
      //                                       SubHeadingTextWidget(
      //                                         title: '${con.state.fromTime.value}',
      //                                         fontWeight: FontWeight.w500,
      //                                         textAlign: TextAlign.start,
      //                                         textColor: Theme.of(context).headingColor,
      //                                       ),
      //                                     ],
      //                                   ),
      //                                   SizedBox(
      //                                     height: mq.height * 0.015,
      //                                   ),
      //                                   Row(
      //                                     mainAxisAlignment:
      //                                     MainAxisAlignment.start,
      //                                     children: [
      //                                       SubHeadingTextWidget(
      //                                         title: '${con.state.toMonthName.value} ${con.state.toDate.value}, ',
      //                                         fontWeight: FontWeight.w500,
      //                                         textAlign: TextAlign.start,
      //                                         textColor: Theme.of(context).headingColor,
      //                                       ),
      //                                       SubHeadingTextWidget(
      //                                         title: '${con.state.toTime.value}',
      //                                         fontWeight: FontWeight.w500,
      //                                         textAlign: TextAlign.start,
      //                                         textColor: Theme.of(context).headingColor,
      //                                       ),
      //                                     ],
      //                                   ),
      //                                 ],
      //                               ),
      //                             );
      //                           }),
      //                         ),
      //                       ],
      //                     ),
      //                   ),
      //                   SizedBox(
      //                     height: mq.height * 0.002,
      //                   ),
      //                 ],
      //               ),
      //             ),
      //           ),
      //           SizedBox(
      //             height: mq.height * 0.015,
      //           ),
      //           RoundButton(
      //             title: 'Enter Location',
      //             onPress: () {},
      //           ),
      //           SizedBox(
      //             height: mq.height * 0.015,
      //           ),
      //         ],
      //       ),
      //     ),
      //   );
      // });
    },
  );
}
