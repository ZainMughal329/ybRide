import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:yb_ride/components/heading_text_widget.dart';
import 'package:yb_ride/components/icon_container.dart';
import 'package:yb_ride/components/reuseable_button.dart';
import 'package:yb_ride/components/text_widget.dart';
import 'package:yb_ride/helper/app_colors.dart';
import 'package:yb_ride/screens/pages/Checkout/index.dart';
import 'package:yb_ride/screens/pages/book_page/widget/2nd_bottom_sheet.dart';
import 'package:yb_ride/screens/pages/book_page/controller.dart';
import 'package:yb_ride/screens/pages/book_page/widget/3rd_bottom_sheet.dart';
import 'package:yb_ride/screens/pages/book_page/widget/date_selection_bottom.dart';

import '../../../../../main.dart';

Future coverageBottomSheet(BuildContext context, CheckOutCon con) {
  final scrollController = ScrollController();

  return showModalBottomSheet(
    // backgroundColor: Theme.of(context).scaffoldBgClr,

    isScrollControlled: true,
    useSafeArea: true,
    context: context,
    // isScrollControlled: true,
    builder: (BuildContext context) {
      return Builder(builder: (BuildContext innerContext) {
        return SingleChildScrollView(
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Spacer(),
                      InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: IconContainer(iconName: 'XMark.png',height: 15,width: 15,
                        ),
                      ),
                      Spacer(flex: 2,),
                      HeadingTextWidget(
                        title: "Custom Coverage",
                        fontWeight: FontWeight.bold,
                        textColor: Theme.of(context).headingColor,
                      ),
                      Spacer(flex: 3,),
                    ],
                  ),
                ),
                Divider(),
                SizedBox(
                  height: mq.height * 0.025,
                ),
                Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: mq.height * .08),
                      child: Column(
                        children: [
                          Obx(
                            () => _buildDetailItem(
                              'Damage Protection (CDW) &\nRoadside',
                              '\$${con.state.CDW} | day',
                              'Avoid paying for any damages done to \nthe car that exceeds a \$500 deductible.',
                              context,
                              con.state.cdwSwitchVal.value,
                              (value) {
                                if (value == true) {
                                  con.state.customValueSelected.value = true;
                                  con.state.cdwSwitchVal.value = true;
                                  con.addInTotalPrice(con.state.CDW,true);
                                  con.removingAllValuesInChekout();
                                } else if (value == false) {
                                  con.state.cdwSwitchVal.value = false;
                                  if (con.state.cdwSwitchVal.value == false &&
                                      con.state.rcliSwitchVal.value == false &&
                                      con.state.assistanceVal.value == false &&
                                      con.state.sliSwitchVal.value == false) {
                                    con.state.customValueSelected.value = false;
                                  }

                                  // con.state.customValueSelected.value = false;
                                  con.removingAllValuesInChekout();
                                  con.subtractFromTotalPrince(con.state.CDW,true);
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Obx(
                            () => _buildDetailItem(
                              'Liability Protection (RCLI)',
                              '\$${con.state.RCLI} | day',
                              'Provides liability insurance which a mandatory legal\nrequirement in all 50 states',
                              context,
                              con.state.rcliSwitchVal.value,
                              (value) {
                                if (value == true) {
                                  con.state.customValueSelected.value = true;
                                  con.state.rcliSwitchVal.value = true;
                                  con.addInTotalPrice(con.state.RCLI,true);
                                  con.removingAllValuesInChekout();
                                } else if (value == false) {
                                  con.state.rcliSwitchVal.value = false;
                                  if (con.state.cdwSwitchVal.value == false &&
                                      con.state.rcliSwitchVal.value == false &&
                                      con.state.assistanceVal.value == false &&
                                      con.state.sliSwitchVal.value == false) {
                                    con.state.customValueSelected.value = false;
                                  }
                                  // con.state.rcliSwitchVal.value = false;
                                  // con.state.customValueSelected.value = false;
                                  con.removingAllValuesInChekout();
                                  con.subtractFromTotalPrince(con.state.RCLI,true);
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Obx(
                            () => _buildDetailItem(
                              'Roadside Assistance',
                              '\$${con.state.assistance} | day',
                              'Covers Roadside Assistance costs',
                              context,
                              con.state.assistanceVal.value,
                              (value) {
                                if (value == true) {
                                  con.state.customValueSelected.value = true;
                                  con.state.assistanceVal.value = true;
                                  con.addInTotalPrice(con.state.assistance,true);
                                  con.removingAllValuesInChekout();
                                } else if (value == false) {
                                  con.state.assistanceVal.value = false;
                                  if (con.state.cdwSwitchVal.value == false &&
                                      con.state.rcliSwitchVal.value == false &&
                                      con.state.assistanceVal.value == false &&
                                      con.state.sliSwitchVal.value == false) {
                                    con.state.customValueSelected.value = false;
                                  }
                                  // con.state.customValueSelected.value = false;
                                  con.removingAllValuesInChekout();
                                  con.subtractFromTotalPrince(
                                      con.state.assistance,true);
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Obx(
                            () => _buildDetailItem(
                              'Supplemental Liability (SLI)',
                              '\$19.99 | day',
                              'Covers supplemental liability beyond State Maximums.\nDoes not replace RCLI',
                              context,
                              con.state.sliSwitchVal.value,
                              (value) {
                                // SLI Code
                                if (value == true) {
                                  con.state.customValueSelected.value = true;
                                  con.state.sliSwitchVal.value = true;
                                  con.addInTotalPrice(con.state.SLI,true);
                                  con.removingAllValuesInChekout();
                                } else if (value == false) {
                                  con.state.sliSwitchVal.value = false;
                                  if (con.state.cdwSwitchVal.value == false &&
                                      con.state.rcliSwitchVal.value == false &&
                                      con.state.assistanceVal.value == false &&
                                      con.state.sliSwitchVal.value == false) {
                                    con.state.customValueSelected.value = false;
                                  }

                                  con.removingAllValuesInChekout();
                                  con.subtractFromTotalPrince(con.state.SLI,true);
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                        bottom: mq.height * 0,
                        left: mq.width * 0,
                        right: mq.width * 0,
                        child: Obx(
                          () => Container(
                            height: mq.height * .14,
                            // Adjust the height based on your design
                            decoration: BoxDecoration(
                                color: Theme.of(context).scaffoldBgClr,
                                border:
                                    Border.all(color: Colors.grey.shade100)),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: mq.height * .01,
                                  horizontal: mq.width * .05),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  HeadingTextWidget(
                                                    title: 'Total price',
                                                    textColor: Theme.of(context)
                                                        .headingColor,
                                                    fontSize: 15,
                                                  ),
                                                  SizedBox(
                                                      width: mq.width * 0.02),
                                                  CircleAvatar(
                                                    radius: 8,
                                                    backgroundColor:
                                                        Theme.of(context)
                                                            .headingColor,
                                                    child: Icon(
                                                      Icons.question_mark,
                                                      color: Theme.of(context)
                                                          .scaffoldBgClr,
                                                      size: 8,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                child: con.priceLoading.value
                                                    ? Center(
                                                        child: Container(
                                                          height: 45,
                                                          width: 60,
                                                          child: Lottie.asset(
                                                              'assets/lottie/loading2.json'),
                                                        ),
                                                      )
                                                    : SubHeadingTextWidget(
                                                        title:
                                                            '\$${con.state.totalPrice.value.toStringAsFixed(2)}',
                                                        fontSize: 13,
                                                        textColor:
                                                            Theme.of(context)
                                                                .lightTextColor,
                                                      ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 20),
                                    ],
                                  ),
                                  SizedBox(width: mq.width * 0.06),
                                  con.state.customValueSelected.value == false
                                      ? InkWell(
                                          onTap: () {},
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                bottom: mq.height * .017),
                                            child: Container(
                                              height: 50,
                                              width: 170,
                                              decoration: BoxDecoration(
                                                color: Color(0xff9e7fde),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10),
                                                  // topRight: Radius.circular(10),
                                                ),
                                              ),
                                              child: Center(
                                                  child: HeadingTextWidget(
                                                title: 'Select Custom Coverage',
                                                textColor: Colors.white,
                                                fontSize: 12,
                                              )),
                                            ),
                                          ),
                                        )
                                      : InkWell(
                                          onTap: () {
                                            con.state.customCoverage.value =
                                                true;
                                            Navigator.pop(context);
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                bottom: mq.height * .017),
                                            child: Container(
                                              height: 50,
                                              width: 190,
                                              decoration: BoxDecoration(
                                                color: AppColors.buttonColor,
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10),
                                                  // topRight: Radius.circular(10),
                                                ),
                                              ),
                                              child: Center(
                                                  child: HeadingTextWidget(
                                                title: 'Add Custom Coverage',
                                                textColor: Colors.white,
                                                fontSize: 14,
                                              )),
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                            ),
                          ),
                        )),
                  ],
                ),
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

Widget _buildDetailItem(String text, String suText, String subHeadingText,
    BuildContext context, bool val, ValueChanged<bool>? onChanged) {
  return Padding(
    padding: EdgeInsets.symmetric(
        horizontal: mq.width * .04, vertical: mq.height * .01),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeadingTextWidget(
                  title: text,
                  textColor: Theme.of(context).headingColor,
                  fontSize: 15,
                  height: 1.25,
                ),
                SizedBox(
                  height: mq.height * .01,
                ),
                SubHeadingTextWidget(
                  title: suText,
                  textColor: Theme.of(context).lightTextColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ],
            ),
            Spacer(),
            _switchButtonWithOutAppSettings(val, onChanged),
          ],
        ),
        SizedBox(
          height: mq.height * .03,
        ),
        SubHeadingTextWidget(
          title: subHeadingText,
          textColor: Theme.of(context).headingColor,
          fontWeight: FontWeight.w600,
          fontSize: 14,
        )
      ],
    ),
  );
}

Widget _switchButtonWithOutAppSettings(
    bool val, ValueChanged<bool>? onChanged) {
  return Switch(
    activeColor: AppColors.whiteColor,
    activeTrackColor: AppColors.buttonColor,
    value: val,
    onChanged: onChanged,
  );
}
