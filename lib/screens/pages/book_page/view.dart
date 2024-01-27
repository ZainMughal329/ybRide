import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:yb_ride/components/heading_text_widget.dart';
import 'package:yb_ride/components/reuseable_button.dart';
import 'package:yb_ride/components/text_widget.dart';
import 'package:yb_ride/helper/app_colors.dart';
import 'package:yb_ride/main.dart';
import 'package:yb_ride/screens/pages/book_page/controller.dart';

class BookNowView extends GetView<BookViewController> {
  const BookNowView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(42.361145, -71.057083),
              zoom: 12,
            ),
          ),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  child: Container(
                    height: mq.height * 0.10,
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
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: mq.height * 0.005,
                            horizontal: mq.width * 0.005,
                          ),
                          child: RoundButton(
                            title: 'Start Searching',
                            onPress: () {
                              Get.bottomSheet(
                                Container(
                                  height: mq.height * 0.6,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: AppColors.whiteColor,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black
                                            .withOpacity(0.5), // Shadow color
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.horizontal_rule,
                                            size: 40,
                                            color: Colors.grey.shade400,
                                          )
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 5),
                                        child: HeadingTextWidget(
                                            title: "Where & When",
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Divider(),
                                      SizedBox(
                                        height: mq.height * 0.015,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15),
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              ListTile(
                                                leading: Icon(
                                                  Icons.location_on,
                                                  size: 30,
                                                ),
                                                title: HeadingTextWidget(
                                                  title:
                                                      'Delivery and return location',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15,
                                                  textColor:
                                                      AppColors.buttonColor,
                                                ),
                                                subtitle: SubHeadingTextWidget(
                                                  title: 'Tap to Search',
                                                ),
                                              ),
                                              Divider(),
                                              Padding(
                                                padding:  EdgeInsets.symmetric(horizontal: mq.width * 0.005),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    SizedBox(width: mq.width*0.005,),
                                                    Flexible(
                                                      child: SubHeadingTextWidget(
                                                        title:
                                                            'Same delivery and return locations',
                                                        fontWeight: FontWeight.w700,
                                                        fontSize: 14,
                                                        textColor:
                                                            AppColors.buttonColor,
                                                      ),
                                                    ),
                                                    Switch(
                                                      value: false,
                                                      onChanged: (val) {},
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                isDismissible: true,
                                barrierColor:
                                    AppColors.whiteColor.withOpacity(0.5),
                                enterBottomSheetDuration:
                                    Duration(milliseconds: 400),
                                exitBottomSheetDuration:
                                    Duration(milliseconds: 400),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
