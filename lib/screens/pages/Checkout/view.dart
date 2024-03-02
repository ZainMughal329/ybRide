import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:yb_ride/components/heading_text_widget.dart';
import 'package:yb_ride/components/icon_container.dart';
import 'package:yb_ride/components/snackbar_widget.dart';
import 'package:yb_ride/components/text_widget.dart';
import 'package:yb_ride/helper/app_colors.dart';
import 'package:yb_ride/helper/app_constants.dart';
import 'package:yb_ride/routes/routes_name.dart';
import 'package:yb_ride/screens/pages/Checkout/controller.dart';
import 'package:yb_ride/screens/pages/Checkout/widgets/addPersonalDetails.dart';
import 'package:yb_ride/screens/pages/Checkout/widgets/agePolicy.dart';
import 'package:yb_ride/screens/pages/Checkout/widgets/card_bottom_sheet.dart';
import 'package:yb_ride/screens/pages/Checkout/widgets/coverge_sheet.dart';
import 'package:yb_ride/screens/pages/Checkout/widgets/delivery_process_read_more.dart';
import 'package:yb_ride/screens/pages/Checkout/widgets/driverLicensealertbox.dart';
import 'package:yb_ride/screens/pages/Checkout/widgets/paymentController.dart';
import 'package:yb_ride/screens/pages/Checkout/widgets/paymentDetailsDialogue.dart';
import 'package:yb_ride/screens/pages/Checkout/widgets/pickUpBottomSheet.dart';
import 'package:yb_ride/screens/pages/Checkout/widgets/promoCodeWidget.dart';
import 'package:yb_ride/screens/pages/Checkout/widgets/viewInstructionsBottomSheet.dart';
import 'package:yb_ride/screens/pages/book_page/car_details/inded.dart';
import '../../../components/custom_Appbar.dart';
import '../../../main.dart';

class CheckOutScreen extends GetView<CheckOutCon> {
  final double carRent;
  final String carType;
  final String id;

  CheckOutScreen({super.key, required this.carRent, required this.carType , required this.id});

  // final controller = Get.put(CheckOutCon());
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CheckOutCon());
    AppConstants.vehicleType = carType;
    controller.getCheckoutPayments();
    controller.getReceiptCharges();
    controller.state.carRent = carRent;
    controller.state.totalPrice.value = carRent;
    controller.applyReferralDiscount();
    print('======>:${AppConstants.tempDeposit.toString()}');
    return Obx(() {
      return controller.state.paymentLoading.value == true
          ? Scaffold(
              backgroundColor: Theme.of(context).scaffoldBgClr,
              appBar: PreferredSize(
                  preferredSize: Size.fromHeight(mq.height * .08),
                  child: CustomAppBarWidget(
                    centerTitle: 'Checkout',
                    isLeading: true,
                    leadingIcon: Icons.arrow_back_ios,
                    leadingPress: () {
                      Navigator.pop(context);
                    },
                  )),
              body: Center(
                child: Container(
                  child: Lottie.asset('assets/lottie/loading2.json',
                      height: 200, width: 200),
                ),
              ),
            )
          : controller.state.dataLoaded.value == false
              ? Scaffold(
                  backgroundColor: Theme.of(context).scaffoldBgClr,
                  appBar: PreferredSize(
                      preferredSize: Size.fromHeight(mq.height * .08),
                      child: CustomAppBarWidget(
                        centerTitle: 'Checkout',
                        isLeading: true,
                        leadingIcon: Icons.arrow_back_ios,
                        leadingPress: () {
                          Navigator.pop(context);
                        },
                      )),
                  body: SafeArea(
                    child: Center(
                      child: Lottie.asset('assets/lottie/loading2.json',
                          height: mq.width / 2, width: mq.width / 2),
                    ),
                  ),
                )
              : Scaffold(
                  backgroundColor: Theme.of(context).scaffoldBgClr,
                  // AppBAr section
                  appBar: PreferredSize(
                      preferredSize: Size.fromHeight(mq.height * .08),
                      child: CustomAppBarWidget(
                        centerTitle: 'Checkout',
                        isLeading: true,
                        leadingIcon: Icons.arrow_back_ios,
                        leadingPress: () {
                          Navigator.pop(context);
                        },
                      )),
                  body: Stack(children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: mq.height * .07, top: 0),
                      child: ListView(
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.symmetric(
                            vertical: mq.height * .03,
                            horizontal: mq.width * .05),
                        children: [
                          // Drive Container
                          Obx(
                            () => controller.state.isContainerVisible.value
                                ? Container(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: mq.height * .02,
                                          horizontal: mq.width * .03),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                child: Icon(
                                                  Icons.done,
                                                  color: Colors.white,
                                                  size: 13,
                                                ),
                                                backgroundColor:
                                                    AppColors.buttonColor,
                                                radius: 8,
                                              ),
                                              SizedBox(
                                                width: mq.width * .02,
                                              ),
                                              HeadingTextWidget(
                                                title:
                                                    'Weekday Savings Included',
                                                textColor:
                                                    AppColors.buttonColor,
                                                fontSize: 14,
                                              ),
                                              SizedBox(
                                                width: mq.width * .12,
                                              ),
                                              GestureDetector(
                                                  onTap: () {
                                                    controller.hideContainer();
                                                  },
                                                  child: Icon(
                                                    FontAwesomeIcons.xmark,
                                                    color: Theme.of(context)
                                                        .headingColor,
                                                    size: 16,
                                                  ))
                                            ],
                                          ),
                                          SizedBox(
                                            height: mq.height * .01,
                                          ),
                                          SubHeadingTextWidget(
                                            title:
                                                'Your booking includes a weekday -you have the best prices 💸',
                                            textColor: Theme.of(context)
                                                .lightTextColor,
                                          ),
                                        ],
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).scaffoldBgClr,
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.1))
                                        ],
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: Theme.of(context)
                                                .scaffoldBgClr)),
                                  )
                                : SizedBox(),
                          ),
                          SizedBox(
                            height: mq.height * .03,
                          ),
                          // Promo code section
                          HeadingTextWidget(
                            title: 'Have a promo code?',
                            fontSize: 14,
                            textColor: Theme.of(context).headingColor,
                          ),
                          SizedBox(
                            height: mq.height * .02,
                          ),
                          GestureDetector(
                            onTap: () {
                              promoCodeBottomSheet(context, controller);
                            },
                            child: Center(
                              child: Container(
                                height: mq.height * .08,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      // vertical: mq.height * .01,
                                      horizontal: mq.width * .02),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Obx(() {
                                            return controller
                                                        .state
                                                        .promoCodeapplied
                                                        .value ==
                                                    true
                                                ? Container()
                                                : IconContainer(
                                                    iconName: 'Star.png',
                                                    height: 30,
                                                    width: 30,
                                                  );
                                          }),
                                          SizedBox(
                                            width: mq.width * .18,
                                          ),
                                          Obx(() {
                                            return controller
                                                        .state
                                                        .promoCodeapplied
                                                        .value ==
                                                    true
                                                ? Container(
                                                    child: Flexible(
                                                      child: HeadingTextWidget(
                                                        title:
                                                            'Promo code discount applied \$-${controller.state.promoDiscount.value}',
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        textColor:
                                                            Theme.of(context)
                                                                .headingColor,
                                                      ),
                                                    ),
                                                  )
                                                : HeadingTextWidget(
                                                    title: 'Add promo code',
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w600,
                                                    textColor: Theme.of(context)
                                                        .headingColor,
                                                  );
                                          }),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                decoration: BoxDecoration(
                                    color: Theme.of(context).scaffoldBgClr,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black.withOpacity(0.1))
                                    ],
                                    border: Border.all(color: Colors.black12)),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: mq.height * .02,
                          ),
                          Divider(
                            color: Colors.black54,
                            thickness: .2,
                          ),
                          SizedBox(
                            height: mq.height * .02,
                          ),
                          // Vehicle section or chnge a car
                          Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      HeadingTextWidget(
                                        title: 'Economy',
                                        fontSize: 14,
                                        textColor:
                                            Theme.of(context).headingColor,
                                      ),
                                      SizedBox(
                                        height: mq.height * .002,
                                      ),
                                      SubHeadingTextWidget(
                                        title: '5 seats . 1 suitcases',
                                        fontSize: 14,
                                        textColor:
                                            Theme.of(context).lightTextColor,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: mq.width * .2,
                                  ),
                                  Container(
                                    height: mq.height * .08,
                                    width: mq.width * .3,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Swiper(
                                      itemBuilder:
                                          (BuildContext context, int ind) {
                                        return Image.asset(
                                          carType == "Premium"
                                              ? controller
                                                  .state.premiumList[ind]
                                              : carType == "Economy"
                                                  ? controller
                                                      .state.economyList[ind]
                                                  : carType ==
                                                          "AllWheelDriveSUV"
                                                      ? controller
                                                          .state.avdList[ind]
                                                      : carType == "SUV"
                                                          ? controller.state
                                                              .suvList[ind]
                                                          : controller.state
                                                              .sedanList[ind],
                                          fit: BoxFit.cover,
                                          // height: 188.h,
                                          width: 288,
                                        );
                                      },
                                      autoplay: false,
                                      itemCount:
                                          controller.state.sedanList.length,
                                      viewportFraction: 0.8,
                                      scale: 0.9,
                                      pagination: SwiperPagination(
                                        alignment: Alignment.bottomCenter,
                                        builder: DotSwiperPaginationBuilder(
                                            color: Colors.black12,
                                            activeColor: Colors.white,
                                            size: 2,
                                            activeSize: 5),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: mq.height * .02,
                              ),
                              // Padding(
                              //     padding: EdgeInsets.only(right: mq.width * .65),
                              //     child: InkWell(
                              //       onTap: () {
                              //         // Get.back();
                              //         // Get.toNamed(RoutesName.carDetailsScreen,arguments: {'isTextShown': true});
                              //         Get.to(()=>
                              //           CarDetailsScreen(isTextShow: true),
                              //         );
                              //       },
                              //       child: HeadingTextWidget(
                              //         title: 'Change car',
                              //         fontWeight: FontWeight.w600,
                              //         fontSize: 14,
                              //         textColor: AppColors.buttonColor,
                              //       ),
                              //     ))
                            ],
                          ),
                          SizedBox(
                            height: mq.height * .02,
                          ),
                          Divider(
                            color: Colors.black54,
                            thickness: .2,
                          ),
                          SizedBox(
                            height: mq.height * .02,
                          ),
                          // Getting the vehicle
                          Row(
                            children: [
                              HeadingTextWidget(
                                title: 'Getting the vehicle',
                                textColor: Theme.of(context).headingColor,
                              ),
                              HeadingTextWidget(
                                textColor: Colors.red,
                                title: " *",
                              ),
                            ],
                          ),
                          SizedBox(
                            height: mq.height * .02,
                          ),
                          Column(
                            children: [
                              Row(
                                // mainAxisAlignment : MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      HeadingTextWidget(
                                        title: 'Delivery',
                                        fontSize: 14,
                                        textColor:
                                            Theme.of(context).headingColor,
                                      ),
                                      SizedBox(
                                        height: mq.height * .002,
                                      ),
                                      SubHeadingTextWidget(
                                        title:
                                            'We will deliver YB-Car to selected \naddress',
                                        fontSize: 14,
                                        textColor:
                                            Theme.of(context).lightTextColor,
                                      )
                                    ],
                                  ),
                                  Spacer(),
                                  // DELIVERY CHECKBOX BUTTON
                                  Obx(
                                    () => Checkbox(
                                      shape: ContinuousRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        side: BorderSide(
                                            color: Colors.grey.withOpacity(.1),
                                            width: .5),
                                      ),
                                      visualDensity: VisualDensity.compact,
                                      value: controller
                                          .state.vehicle_delivery.value,
                                      onChanged: (bool? value) {
                                        controller.priceLoadingFunc();
                                        controller.state.vehicle_delivery
                                            .value = value!;
                                        if (value == true) {
                                          if (controller
                                                  .state.vehicle_pickup.value ==
                                              true) {
                                            controller.state.vehicle_pickup
                                                .value = false;
                                          }
                                          controller.addInTotalPrice(
                                              controller.state.delivery, false);
                                        } else if (value == false) {
                                          controller.subtractFromTotalPrince(
                                              controller.state.delivery, false);
                                        }
                                        controller.state.vehicle_delivery
                                            .value = value;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: mq.height * .02,
                          ),
                          // Column(
                          //   children: [
                          //     Row(
                          //       // crossAxisAlignment: CrossAxisAlignment.center,
                          //       children: [
                          //         Column(
                          //           mainAxisAlignment: MainAxisAlignment.start,
                          //           crossAxisAlignment:
                          //               CrossAxisAlignment.start,
                          //           children: [
                          //             HeadingTextWidget(
                          //               title: 'Pickup',
                          //               fontSize: 14,
                          //               textColor:
                          //                   Theme.of(context).headingColor,
                          //             ),
                          //             SizedBox(
                          //               height: mq.height * .002,
                          //             ),
                          //             SubHeadingTextWidget(
                          //               title:
                          //                   'Meet us at our lot and save \non delivery fees',
                          //               fontSize: 14,
                          //               textColor:
                          //                   Theme.of(context).lightTextColor,
                          //             ),
                          //           ],
                          //         ),
                          //         Spacer(),
                          //         // PICKUP CHECK BOX
                          //         Obx(
                          //           () => Checkbox(
                          //             shape: ContinuousRectangleBorder(
                          //               borderRadius: BorderRadius.circular(8),
                          //               side: BorderSide(
                          //                   color: Colors.grey.withOpacity(.1),
                          //                   width: .5),
                          //             ),
                          //             visualDensity: VisualDensity.compact,
                          //             value:
                          //                 controller.state.vehicle_pickup.value,
                          //             onChanged: (bool? value) {
                          //               controller.priceLoadingFunc();
                          //               if (value == true) {
                          //                 if (controller.state.vehicle_delivery
                          //                         .value ==
                          //                     true) {
                          //                   controller.state.vehicle_delivery
                          //                       .value = false;
                          //                   controller.subtractFromTotalPrince(
                          //                       controller.state.delivery,
                          //                       false);
                          //                 }
                          //                 pickUpBottomSheet(
                          //                     context, controller);
                          //               }
                          //
                          //               controller.state.vehicle_pickup.value =
                          //                   value!;
                          //             },
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //   ],
                          // ),
                          SizedBox(
                            height: mq.height * .02,
                          ),
                          Obx(() {
                            return controller.state.vehicle_pickup.value
                                ? SubHeadingTextWidget(
                                    title:
                                        'Pick up your YbRide within a 2-hour window from your scheduled start.',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13,
                                    textColor: Theme.of(context).lightTextColor,
                                  )
                                : controller.state.vehicle_delivery.value
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          HeadingTextWidget(
                                            title:
                                                'Your YB-Buddy will wait 10 minutes upon arrival',
                                            fontWeight: FontWeight.w700,
                                            fontSize: 13,
                                            textColor: Theme.of(context)
                                                .lightTextColor,
                                          ),
                                          SubHeadingTextWidget(
                                            title:
                                                'Get delivery updates, track your buddy\'s location, and contact your buddy via our app.',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 13,
                                            textColor: Theme.of(context)
                                                .lightTextColor,
                                          )
                                        ],
                                      )
                                    : Container();
                          }),
                          // SizedBox(
                          //   height: mq.height * .02,
                          // ),
                          Obx(() {
                            return controller.state.vehicle_pickup.value
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: mq.height * .02,
                                      ),

                                      // Instructions Bottom Sheet
                                      InkWell(
                                        onTap: () async {
                                          await viewInstructionsBottomSheet(
                                              context);
                                        },
                                        child: HeadingTextWidget(
                                          title: 'View instructions',
                                          textColor: AppColors.buttonColor,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  )
                                : Container();
                          }),
                          SizedBox(
                            height: mq.height * .02,
                          ),
                          Divider(
                            color: Colors.black54,
                            thickness: .2,
                          ),
                          SizedBox(
                            height: mq.height * .02,
                          ),
                          // Where and When
                          Obx(() {
                            return controller.state.vehicle_delivery.value ==
                                        true ||
                                    controller.state.vehicle_pickup.value ==
                                        true
                                ? Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        HeadingTextWidget(
                                          title: 'Where & When',
                                          textColor:
                                              Theme.of(context).headingColor,
                                        ),
                                        SizedBox(
                                          height: mq.height * .02,
                                        ),
                                        Column(
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                IconContainer(
                                                  iconName:
                                                      'DeliveryLocIcon.png',
                                                  height: 20,
                                                  width: 20,
                                                ),
                                                SizedBox(width: 8),
                                                Container(
                                                  width: mq.width * 0.7,
                                                  // Set a fixed width for the container
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      HeadingTextWidget(
                                                        title: controller
                                                                .state
                                                                .vehicle_delivery
                                                                .value
                                                            ? AppConstants
                                                                .fromAddress
                                                                .toString()
                                                            : controller
                                                                .state.pickupLoc
                                                                .toString(),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        maxLines: 2,
                                                        textColor:
                                                            Theme.of(context)
                                                                .headingColor,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Spacer(),
                                                // GestureDetector(
                                                //     onTap: () {},
                                                //     child: HeadingTextWidget(
                                                //       title: 'Edit',
                                                //       fontSize: 15,
                                                //       textColor:
                                                //       AppColors.buttonColor,
                                                //     ),
                                                // ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: mq.height * .02,
                                        ),
                                        Column(
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                IconContainer(
                                                  iconName: 'smallCircle.png',
                                                  height: 20,
                                                  width: 10,
                                                ),
                                                SizedBox(width: 14),
                                                Container(
                                                  width: mq.width * 0.7,
                                                  // Set a fixed width for the container
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      HeadingTextWidget(
                                                        title: controller
                                                                .state
                                                                .vehicle_delivery
                                                                .value
                                                            ? AppConstants
                                                                .toAddress
                                                                .toString()
                                                            : controller
                                                                .state.pickupLoc
                                                                .toString(),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        maxLines: 2,
                                                        textColor:
                                                            Theme.of(context)
                                                                .headingColor,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Spacer(),
                                                // GestureDetector(
                                                //     onTap: () {},
                                                //     child: HeadingTextWidget(
                                                //       title: 'Edit',
                                                //       fontSize: 15,
                                                //       textColor:
                                                //       AppColors.buttonColor,
                                                //     ),
                                                //        ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: mq.height * .02,
                                        ),
                                        Column(
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                IconContainer(
                                                  iconName: 'Calender.png',
                                                  height: 20,
                                                  width: 20,
                                                ),
                                                SizedBox(width: 8),
                                                Container(
                                                  width: mq.width * 0.7,
                                                  // Set a fixed width for the container
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      HeadingTextWidget(
                                                        title:
                                                            '${AppConstants.fromMonthName} ${AppConstants.fromDate}, ${AppConstants.fromTime}',
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        maxLines: 2,
                                                        textColor:
                                                            Theme.of(context)
                                                                .headingColor,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            mq.height * .006,
                                                      ),
                                                      HeadingTextWidget(
                                                        title:
                                                            '${AppConstants.toMonthName} ${AppConstants.toDate}, ${AppConstants.toTime}',
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        maxLines: 2,
                                                        textColor:
                                                            Theme.of(context)
                                                                .headingColor,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Spacer(),
                                                // GestureDetector(
                                                //     onTap: () {},
                                                //     child: HeadingTextWidget(
                                                //       title: 'Edit',
                                                //       fontSize: 15,
                                                //       textColor:
                                                //       AppColors.buttonColor,
                                                //     ),
                                                // ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: mq.height * .02,
                                        ),
                                        Divider(
                                          color: Colors.black54,
                                          thickness: .2,
                                        ),
                                      ],
                                    ),
                                  )
                                : Container();
                          }),

                          SizedBox(
                            height: mq.height * .02,
                          ),
                          // Delivery process
                          Obx(() {
                            return controller.state.vehicle_delivery.value ==
                                    true
                                ? Column(
                                    children: [
                                      Column(
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Image(
                                                image: AssetImage(
                                                    'assets/images/clock.jpeg'),
                                                height: mq.height * .05,
                                                width: mq.width * .05,
                                              ),
                                              SizedBox(width: 8),
                                              HeadingTextWidget(
                                                title: 'Delivery process',
                                                textColor: Theme.of(context)
                                                    .headingColor,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: mq.height * .02,
                                      ),
                                      HeadingTextWidget(
                                        title:
                                            'Your YBRide Buddy will wait 10 minutes upon arrival,',
                                        fontSize: 14,
                                        textColor:
                                            Theme.of(context).headingColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      SizedBox(
                                        height: mq.height * .004,
                                      ),
                                      SubHeadingTextWidget(
                                        title:
                                            "We will keep you updated on your buddy's estimated arrival time through text and/ or push notifications. Enjoy your trip!",
                                        fontSize: 13,
                                        textColor:
                                            Theme.of(context).lightTextColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      SizedBox(
                                        height: mq.height * .02,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          deliveryProcessSheet(context);
                                        },
                                        child: HeadingTextWidget(
                                          title: 'Read more',
                                          fontSize: 14,
                                          textColor: AppColors.buttonColor,
                                        ),
                                      ),
                                      SizedBox(
                                        height: mq.height * .02,
                                      ),
                                      Divider(
                                        color: Colors.black54,
                                        thickness: .2,
                                      ),
                                    ],
                                  )
                                : Container();
                          }),
                          //delivery text
                          // Coverage
                          Row(
                            children: [
                              HeadingTextWidget(
                                title: 'Coverage',
                                textColor: Theme.of(context).headingColor,
                              ),
                              HeadingTextWidget(
                                textColor: Colors.red,
                                title: " *",
                              ),
                            ],
                          ),
                          SizedBox(
                            height: mq.height * .02,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      HeadingTextWidget(
                                        title: 'Standard Protection',
                                        textColor:
                                            Theme.of(context).headingColor,
                                        fontSize: 14,
                                      ),
                                      SizedBox(
                                        height: mq.height * .002,
                                      ),
                                      SubHeadingTextWidget(
                                        title:
                                            '\$${controller.state.standard} | day',
                                        textColor:
                                            Theme.of(context).lightTextColor,
                                        fontSize: 14,
                                      )
                                    ],
                                  ),
                                  Spacer(),
                                  Obx(
                                    () => Checkbox(
                                      shape: ContinuousRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        side: BorderSide(
                                            color: Colors.grey.withOpacity(.1),
                                            width: .5),
                                      ),
                                      visualDensity: VisualDensity.compact,
                                      value: controller
                                          .state.standard_protection.value,
                                      onChanged: (bool? value) {
                                        controller.priceLoadingFunc();
                                        if (value == true) {
                                          controller.addInTotalPrice(
                                              controller.state.standard, true);
                                          //checking if value was true , and then subtracting it
                                          if (controller.state
                                                  .essential_protection.value ==
                                              true) {
                                            controller.subtractFromTotalPrince(
                                                controller.state.essential,
                                                true);
                                          }
                                          if (controller
                                                  .state.customCoverage.value ==
                                              true) {
                                            if (controller
                                                    .state.cdwSwitchVal.value ==
                                                true) {
                                              controller
                                                  .subtractFromTotalPrince(
                                                      controller.state.CDW,
                                                      true);
                                            }
                                            if (controller.state.rcliSwitchVal
                                                    .value ==
                                                true) {
                                              controller
                                                  .subtractFromTotalPrince(
                                                      controller.state.RCLI,
                                                      true);
                                            }
                                            if (controller.state.assistanceVal
                                                    .value ==
                                                true) {
                                              controller
                                                  .subtractFromTotalPrince(
                                                      controller
                                                          .state.assistance,
                                                      true);
                                            }
                                            if (controller
                                                    .state.sliSwitchVal.value ==
                                                true) {
                                              controller
                                                  .subtractFromTotalPrince(
                                                      controller.state.SLI,
                                                      true);
                                            }
                                          }
                                          // false the rest of protection values
                                          controller.state.essential_protection
                                              .value = false;
                                          controller.state.i_have_own.value =
                                              false;
                                          controller.state.essential_protection
                                              .value = false;
                                          controller.state.customCoverage
                                              .value = false;
                                          controller.state.customValueSelected
                                              .value = false;
                                          controller.state.cdwSwitchVal.value =
                                              false;
                                          controller.state.rcliSwitchVal.value =
                                              false;
                                          controller.state.assistanceVal.value =
                                              false;
                                          controller.state.sliSwitchVal.value =
                                              false;
                                          //updating checkboxValue
                                          controller.state.standard_protection
                                              .value = true;
                                        } else if (value == false) {
                                          controller.subtractFromTotalPrince(
                                              controller.state.standard, true);
                                          controller.state.standard_protection
                                              .value = false;
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: mq.height * .02,
                          ),
                          SubHeadingTextWidget(
                            title:
                                'Provides liability insurance which is a mandatory legal requirement in all 50 states, covers any damage done to the car past a \$500 deduction. Includes Roadside Assistance.',
                            fontWeight: FontWeight.w500,
                            textColor: Theme.of(context).lightTextColor,
                            fontSize: 13,
                          ),
                          SizedBox(
                            height: mq.height * .02,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      HeadingTextWidget(
                                        textColor:
                                            Theme.of(context).headingColor,
                                        title: 'Liability Insurance',
                                        fontSize: 14,
                                      ),
                                      SizedBox(
                                        height: mq.height * .002,
                                      ),
                                      SubHeadingTextWidget(
                                        title:
                                            '\$${controller.state.essential} | day',
                                        textColor:
                                            Theme.of(context).lightTextColor,
                                        fontSize: 14,
                                      )
                                    ],
                                  ),
                                  Spacer(), // Add spacing between text and circle
                                  Obx(
                                    () => Checkbox(
                                      shape: ContinuousRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        side: BorderSide(
                                            color: Colors.grey.withOpacity(.1),
                                            width: .5),
                                      ),
                                      visualDensity: VisualDensity.compact,
                                      value: controller
                                          .state.essential_protection.value,
                                      onChanged: (bool? value) {
                                        controller.priceLoadingFunc();
                                        if (value == true) {
                                          controller.addInTotalPrice(
                                              controller.state.essential, true);
                                          //checking if value was true , and then subtracting it
                                          if (controller.state
                                                  .standard_protection.value ==
                                              true) {
                                            controller.subtractFromTotalPrince(
                                                controller.state.standard,
                                                true);
                                          }
                                          if (controller
                                                  .state.customCoverage.value ==
                                              true) {
                                            if (controller
                                                    .state.cdwSwitchVal.value ==
                                                true) {
                                              controller
                                                  .subtractFromTotalPrince(
                                                      controller.state.CDW,
                                                      true);
                                            }
                                            if (controller.state.rcliSwitchVal
                                                    .value ==
                                                true) {
                                              controller
                                                  .subtractFromTotalPrince(
                                                      controller.state.RCLI,
                                                      true);
                                            }
                                            if (controller.state.assistanceVal
                                                    .value ==
                                                true) {
                                              controller
                                                  .subtractFromTotalPrince(
                                                      controller
                                                          .state.assistance,
                                                      true);
                                            }
                                            if (controller
                                                    .state.sliSwitchVal.value ==
                                                true) {
                                              controller
                                                  .subtractFromTotalPrince(
                                                      controller.state.SLI,
                                                      true);
                                            }
                                          }
                                          // false the rest of protection values
                                          controller.state.standard_protection
                                              .value = false;
                                          controller.state.i_have_own.value =
                                              false;
                                          controller.state.essential_protection
                                              .value = false;
                                          controller.state.customValueSelected
                                              .value = false;
                                          controller.state.customCoverage
                                              .value = false;
                                          controller.state.cdwSwitchVal.value =
                                              false;
                                          controller.state.rcliSwitchVal.value =
                                              false;
                                          controller.state.assistanceVal.value =
                                              false;
                                          controller.state.sliSwitchVal.value =
                                              false;
                                          //updating checkboxValue
                                          controller.state.essential_protection
                                              .value = true;
                                        } else if (value == false) {
                                          controller.subtractFromTotalPrince(
                                              controller.state.essential, true);
                                          controller.state.essential_protection
                                              .value = false;
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: mq.height * .02,
                          ),
                          SubHeadingTextWidget(
                            title:
                                'Provides liability insurance which is a mandatory legal requirement in all 50 states, Driving without liability insurance us illegal',
                            textColor: Theme.of(context).lightTextColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                          ),
                          SizedBox(
                            height: mq.height * .02,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      HeadingTextWidget(
                                        title: 'I have my own',
                                        textColor:
                                            Theme.of(context).headingColor,
                                        fontSize: 14,
                                      ),
                                      SizedBox(
                                        height: mq.height * .002,
                                      ),
                                      SubHeadingTextWidget(
                                        title: '\$0.00 | day',
                                        textColor:
                                            Theme.of(context).lightTextColor,
                                        fontSize: 14,
                                      )
                                    ],
                                  ),
                                  Spacer(), // Add spacing between text and circle
                                  Obx(
                                    () => Checkbox(
                                      shape: ContinuousRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        side: BorderSide(
                                            color: Colors.grey.withOpacity(.1),
                                            width: .5),
                                      ),
                                      visualDensity: VisualDensity.compact,
                                      value: controller.state.i_have_own.value,
                                      onChanged: (bool? value) {
                                        controller.priceLoadingFunc();
                                        if (value == true) {
                                          // controller.addInTotalPrice(controller.state.essential);
                                          //checking if value was true , and then subtracting it
                                          if (controller.state
                                                  .standard_protection.value ==
                                              true) {
                                            controller.subtractFromTotalPrince(
                                                controller.state.standard,
                                                true);
                                          }
                                          if (controller
                                                  .state.customCoverage.value ==
                                              true) {
                                            if (controller
                                                    .state.cdwSwitchVal.value ==
                                                true) {
                                              controller
                                                  .subtractFromTotalPrince(
                                                      controller.state.CDW,
                                                      true);
                                            }
                                            if (controller
                                                    .state.cdwSwitchVal.value ==
                                                true) {
                                              controller
                                                  .subtractFromTotalPrince(
                                                      controller.state.RCLI,
                                                      true);
                                            }
                                            if (controller
                                                    .state.cdwSwitchVal.value ==
                                                true) {
                                              controller
                                                  .subtractFromTotalPrince(
                                                      controller
                                                          .state.assistance,
                                                      true);
                                            }
                                            if (controller
                                                    .state.cdwSwitchVal.value ==
                                                true) {
                                              controller
                                                  .subtractFromTotalPrince(
                                                      controller.state.SLI,
                                                      true);
                                            }
                                          }
                                          if (controller.state
                                                  .essential_protection.value ==
                                              true) {
                                            controller.subtractFromTotalPrince(
                                                controller.state.essential,
                                                true);
                                          }
                                          // false the rest of protection values
                                          controller.state.standard_protection
                                              .value = false;
                                          controller.state.essential_protection
                                              .value = false;
                                          controller.state.customCoverage
                                              .value = false;
                                          controller.state.customValueSelected
                                              .value = false;
                                          controller.state.cdwSwitchVal.value =
                                              false;
                                          controller.state.rcliSwitchVal.value =
                                              false;
                                          controller.state.assistanceVal.value =
                                              false;
                                          controller.state.sliSwitchVal.value =
                                              false;
                                          //updating checkboxValue
                                          controller.state.i_have_own.value =
                                              true;
                                        } else if (value == false) {
                                          // controller.subtractFromTotalPrince(controller.state.essential);
                                          controller.state.i_have_own.value =
                                              false;
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: mq.height * .02,
                          ),
                          SubHeadingTextWidget(
                            title:
                                'You have your own insurance that complies with local requirements. You understand that it is illegal to drive without liability insurance, and that you will be liable for any damage done to a 3rd party.',
                            textColor: Theme.of(context).lightTextColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                          ),
                          SizedBox(
                            height: mq.height * .03,
                          ),
                          // CustomCoverageSheet
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  // controller.priceLoading();
                                  coverageBottomSheet(context, controller);
                                },
                                child: HeadingTextWidget(
                                  title: 'Add custom coverage',
                                  fontSize: 16,
                                  textColor: AppColors.buttonColor,
                                ),
                              ),
                              Spacer(),
                              Obx(
                                () => Checkbox(
                                  shape: ContinuousRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    side: BorderSide(
                                        color: Colors.grey.withOpacity(.1),
                                        width: .5),
                                  ),
                                  visualDensity: VisualDensity.compact,
                                  value: controller.state.customCoverage.value,
                                  onChanged: (bool? value) {
                                    controller.priceLoadingFunc();
                                    if (value == true) {
                                      coverageBottomSheet(context, controller);
                                    } else if (value == false) {
                                      if (controller.state.cdwSwitchVal.value ==
                                          true) {
                                        controller.subtractFromTotalPrince(
                                            controller.state.CDW, true);
                                      }
                                      if (controller
                                              .state.rcliSwitchVal.value ==
                                          true) {
                                        controller.subtractFromTotalPrince(
                                            controller.state.RCLI, true);
                                      }
                                      if (controller
                                              .state.assistanceVal.value ==
                                          true) {
                                        controller.subtractFromTotalPrince(
                                            controller.state.assistance, true);
                                      }
                                      if (controller.state.sliSwitchVal.value ==
                                          true) {
                                        controller.subtractFromTotalPrince(
                                            controller.state.SLI, true);
                                      }
                                      controller.removingAllValuesInChekout();
                                      controller.state.customValueSelected
                                          .value = false;
                                      controller.state.customCoverage.value =
                                          false;
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: mq.height * .02,
                          ),
                          Divider(
                            color: Colors.black54,
                            thickness: .2,
                          ),
                          SizedBox(
                            height: mq.height * .02,
                          ),
                          // Extras section
                          HeadingTextWidget(
                            textColor: Theme.of(context).headingColor,
                            title: 'Extras',
                          ),
                          SizedBox(
                            height: mq.height * .02,
                          ),
                          Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      HeadingTextWidget(
                                        title: 'Unlimited miles',
                                        textColor:
                                            Theme.of(context).headingColor,
                                        fontSize: 14,
                                      ),
                                      SizedBox(
                                        height: mq.height * .002,
                                      ),
                                      SubHeadingTextWidget(
                                        textColor:
                                            Theme.of(context).lightTextColor,
                                        title:
                                            '\$${controller.state.unlimitedMiles} | day',
                                        fontSize: 14,
                                      )
                                    ],
                                  ),
                                  Spacer(), // Add spacing between text and circle
                                  Obx(
                                    () => Checkbox(
                                      shape: ContinuousRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        side: BorderSide(
                                            color: Colors.grey.withOpacity(.1),
                                            width: .5),
                                      ),
                                      visualDensity: VisualDensity.compact,
                                      value:
                                          controller.state.extraSwitchVal.value,
                                      onChanged: (bool? value) {
                                        controller.priceLoadingFunc();
                                        if (value == true) {
                                          controller.addInTotalPrice(
                                              controller.state.unlimitedMiles,
                                              true);
                                        } else if (value == false) {
                                          controller.subtractFromTotalPrince(
                                              controller.state.unlimitedMiles,
                                              true);
                                        }
                                        controller.state.extraSwitchVal.value =
                                            value!;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: mq.height * .02,
                          ),
                          SubHeadingTextWidget(
                              title:
                                  'Your rental includes 1800 miles. You will pay \$0.45/mile thereafter.',
                              textColor: Theme.of(context).lightTextColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 13),
                          SizedBox(
                            height: mq.height * .02,
                          ),
                          Divider(
                            color: Colors.black54,
                            thickness: .2,
                          ),
                          SizedBox(
                            height: mq.height * .02,
                          ),
                          // Drivers Section
                          HeadingTextWidget(
                            textColor: Theme.of(context).headingColor,
                            title: 'Drivers',
                          ),
                          SizedBox(
                            height: mq.height * .02,
                          ),
                          Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    backgroundColor:
                                        Colors.blueGrey.withOpacity(.3),
                                    child: Icon(
                                      Icons.person,
                                      color: Theme.of(context).headingColor,
                                    ),
                                  ),
                                  SizedBox(
                                    width: mq.width * .03,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      HeadingTextWidget(
                                        title: 'You',
                                        textColor:
                                            Theme.of(context).headingColor,
                                        fontSize: 14,
                                      ),
                                      SizedBox(
                                        height: mq.height * .002,
                                      ),
                                      SubHeadingTextWidget(
                                        title: 'Not verified',
                                        fontSize: 14,
                                        textColor: Colors.red.withOpacity(.6),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: mq.height * .02,
                          ),
                          Row(
                            children: [
                              Obx(
                                () => Checkbox(
                                  shape: ContinuousRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    side: BorderSide(
                                        color: Colors.grey.withOpacity(.1),
                                        width: .5),
                                  ),
                                  visualDensity: VisualDensity.compact,
                                  value:
                                      controller.state.driversCheckBoxVal.value,
                                  onChanged: (bool? value) {
                                    controller.priceLoadingFunc();
                                    if (value == true) {
                                      controller.addInTotalPrice(
                                          controller.state.licenseFee, true);
                                    } else if (value == false) {
                                      controller.subtractFromTotalPrince(
                                          controller.state.licenseFee, true);
                                    }
                                    controller.state.driversCheckBoxVal.value =
                                        value!;
                                  },
                                ),
                              ),
                              SizedBox(width: mq.width * 0.002),
                              SubHeadingTextWidget(
                                  textColor: Theme.of(context).lightTextColor,
                                  title: 'I am under 25 years old',
                                  fontSize: 14),
                              SizedBox(width: mq.width * 0.02),
                              CircleAvatar(
                                radius: 6,
                                backgroundColor: Theme.of(context).headingColor,
                                child: Icon(
                                  Icons.question_mark,
                                  color: Colors.white,
                                  size: 8,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: mq.height * .01,
                          ),
                          SubHeadingTextWidget(
                            title:
                                "Drivers License verification is required, you'll receive instructions after payment.",
                            textColor: Theme.of(context).lightTextColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(
                            height: mq.height * .03,
                          ),
                          SubHeadingTextWidget(
                            title:
                                'Add additional driver fee of cost after bookings!',
                            textColor: Theme.of(context).lightTextColor,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(
                            height: mq.height * .02,
                          ),
                          GestureDetector(
                            onTap: () {
                              showCustomAlertDialog(context);
                            },
                            child: HeadingTextWidget(
                                title: 'See Details',
                                fontSize: 16,
                                textColor: AppColors.buttonColor),
                          ),
                          SizedBox(
                            height: mq.height * .03,
                          ),
                          Divider(
                            color: Colors.black54,
                            thickness: .2,
                          ),
                          SizedBox(
                            height: mq.height * .02,
                          ),
                          // Deposit Policy section
                          Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image(
                                    image:
                                        AssetImage('assets/images/card.jpeg'),
                                    height: mq.height * .05,
                                    width: mq.width * .05,
                                  ),
                                  SizedBox(width: 8),
                                  HeadingTextWidget(
                                    title: 'Deposit policy',
                                    textColor: Theme.of(context).headingColor,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: mq.height * .02,
                          ),
                          SubHeadingTextWidget(
                            title:
                                'A temporary deposit of \$${AppConstants.tempDeposit} will be held on your card 24 hours before your trip starts.'
                                ' Typically, YbRide releases this deposit 3 days after your trip ends, but your bank may take an additional 5-10 business days for processing.'
                                ' Trips longer than 27 days will have the deposit captured and refunded after your trip',
                            textColor: Theme.of(context).lightTextColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(
                            height: mq.height * .02,
                          ),
                          Divider(
                            color: Colors.black54,
                            thickness: .2,
                          ),
                          SizedBox(
                            height: mq.height * .02,
                          ),
                          // Minimum age policy
                          HeadingTextWidget(
                            textColor: Theme.of(context).headingColor,
                            title: 'Minimum age policy',
                          ),
                          SizedBox(
                            height: mq.height * .03,
                          ),
                          InkWell(
                            onTap: () {
                              agePolicySheet(context);
                            },
                            child: HeadingTextWidget(
                              title: 'Open minimum age policy',
                              textColor: AppColors.buttonColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                          SizedBox(
                            height: mq.height * .03,
                          ),
                          Divider(
                            color: Colors.black54,
                            thickness: .2,
                          ),
                          SizedBox(
                            height: mq.height * .03,
                          ),
                          // Cancelation policy
                          Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image(
                                    image: AssetImage(
                                        'assets/images/signals.jpeg'),
                                    height: mq.height * .05,
                                    width: mq.width * .05,
                                  ),
                                  SizedBox(width: 8),
                                  HeadingTextWidget(
                                    title: 'Cancellation policy',
                                    textColor: Theme.of(context).headingColor,
                                  )
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: mq.height * .02,
                          ),
                          SubHeadingTextWidget(
                            title:
                                "Free cancellation until 48h before start. By closing the booking, you confirm that you've read and accepted the trip information and the terms and conditions",
                            textColor: Theme.of(context).lightTextColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(
                            height: mq.height * .03,
                          ),
                          GestureDetector(
                            onTap: () {
                              viewInstructionsBottomSheet(context);
                            },
                            child: HeadingTextWidget(
                              title: 'See terms and conditions',
                              textColor: AppColors.buttonColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(
                            height: mq.height * .02,
                          ),
                          Divider(
                            color: Colors.black54,
                            thickness: .2,
                          ),
                          SizedBox(
                            height: mq.height * .02,
                          ),
                          // Payment method
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  HeadingTextWidget(
                                    textColor: Theme.of(context).headingColor,
                                    title: 'Referral Credits',
                                  ),
                                  SubHeadingTextWidget(
                                      title:
                                          'Discount will be applied\nautomatically',textColor: AppColors.buttonColor,),
                                ],
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              SubHeadingTextWidget(
                                  title: '\$${AppConstants.referralDiscount}',
                                textColor: Theme.of(context).headingColor,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: mq.height * .02,
                          ),
                          HeadingTextWidget(
                            textColor: Theme.of(context).headingColor,
                            title: 'Apply promo discount',
                          ),
                          SizedBox(
                            height: mq.height * .03,
                          ),

                          SizedBox(
                            height: mq.height * .03,
                          ),
                          Obx(() {
                            return controller.state.promoCodeapplied.value ==
                                    true
                                ? Container(
                                    child: Flexible(
                                      child: HeadingTextWidget(
                                        title:
                                            'Promo code discount applied \$-${controller.state.promoDiscount.value}',
                                        textColor: AppColors.buttonColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      promoCodeBottomSheet(context, controller);
                                    },
                                    child: HeadingTextWidget(
                                      title: 'Add promo code',
                                      textColor: AppColors.buttonColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  );
                          }),
                          SizedBox(
                            height: mq.height * .03,
                          ),
                          SizedBox(
                            height: mq.height * .05,
                          ),
                        ],
                      ),
                    ),
                    // Button Section
                    Positioned(
                        bottom: mq.height * 0,
                        left: mq.width * 0,
                        right: mq.width * 0,
                        child: Container(
                          height: mq.height * .14,
                          // Adjust the height based on your design
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBgClr,
                            border: Border.all(color: Colors.grey.shade100),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                              // topRight: Radius.circular(10),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: mq.height * .01,
                                horizontal: mq.width * .05),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                            Obx(
                                              () {
                                                return controller.priceLoading
                                                            .value ==
                                                        true
                                                    ? Lottie.asset(
                                                        'assets/lottie/loading2.json',
                                                        height: 30,
                                                        width: 50)
                                                    : SubHeadingTextWidget(
                                                        title:
                                                            '\$${controller.state.totalPrice.value.toStringAsFixed(2)}',
                                                        fontSize: 13,
                                                        textColor:
                                                            Theme.of(context)
                                                                .lightTextColor,
                                                      );
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20),
                                  ],
                                ),
                                SizedBox(width: mq.width * 0.06),
                                Obx(() {
                                  return controller
                                              .state.personalInfoAdded.value ==
                                          true
                                      ? InkWell(
                                          onTap: () async {
                                            print('Book and Pay');
                                            //setting values in appConstants
                                            setValues();
                                            //displaying reciept Bottom Sheet

                                            showRecipetSheet(
                                              id,
                                              context,
                                              AppConstants.rentDays,
                                              AppConstants.totalPrice
                                                  .toStringAsFixed(2),
                                              DateTime.now().toString(),
                                              '${AppConstants.fromDate} ${AppConstants.fromTime}',
                                              '${AppConstants.toDate} ${AppConstants.toTime}',
                                              AppConstants.rentDays,
                                              AppConstants.bookingDate,
                                              'Card Payment',
                                              {
                                                'Liability Charges\nRent & others':
                                                    AppConstants.totalPrice,
                                                '${AppConstants.selectedPlaceState.contains('MA, USA') ? 'Massachusetts' : AppConstants.selectedPlaceState.contains('VA, USA') ? 'Virginia' : AppConstants.selectedPlaceState.contains('MD, USA') ? 'MarryLand' : 'District of Columbia'} Police Training Fees':
                                                    AppConstants
                                                        .bostonPoliceFees,
                                                '${AppConstants.selectedPlaceState.contains('MA, USA') ? 'Massachusetts' : AppConstants.selectedPlaceState.contains('VA, USA')  ? 'Virginia' : AppConstants.selectedPlaceState.contains('MD, USA') ? 'MarryLand' : 'District of Columbia'} Parking Surcharge':
                                                    AppConstants.bostonParking,
                                                '${AppConstants.selectedPlaceState.contains('MA, USA') ? 'Massachusetts' : AppConstants.selectedPlaceState.contains('VA, USA')  ? 'Virginia' : AppConstants.selectedPlaceState.contains('MD, USA') ? 'MarryLand' : 'District of Columbia'} Convention Center\nFinancing Surcharge':
                                                    AppConstants
                                                        .bostonConventionCenter,
                                                'Delivery and Return':
                                                    AppConstants
                                                        .deliveryCharges,
                                                'Temporary Deposit':
                                                    AppConstants.tempDeposit,
                                              },
                                            );
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                bottom: mq.height * .017),
                                            child: Container(
                                              height: 50,
                                              width: 170,
                                              decoration: BoxDecoration(
                                                color: AppColors.buttonColor
                                                    .withOpacity(0.8),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10),
                                                  // topRight: Radius.circular(10),
                                                ),
                                              ),
                                              child: Center(
                                                  child: HeadingTextWidget(
                                                title: 'Book and Pay',
                                                textColor: Colors.white,
                                                fontSize: 14,
                                              )),
                                            ),
                                          ),
                                        )
                                      : InkWell(
                                          onTap: () {
                                            if (controller
                                                .checkNecessaryFieldsAdded()) {
                                              addPersonalDataSheet(
                                                  context, controller);
                                            } else {
                                              Snackbar.showSnackBar(
                                                  "YB-Ride",
                                                  "Select Necessary Requirments",
                                                  Icons.error_outline);
                                            }
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                bottom: mq.height * .017),
                                            child: Container(
                                              height: 50,
                                              width: 170,
                                              decoration: BoxDecoration(
                                                color: AppColors.buttonColor
                                                    .withOpacity(0.8),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10),
                                                  // topRight: Radius.circular(10),
                                                ),
                                              ),
                                              child: Center(
                                                  child: HeadingTextWidget(
                                                title: 'Add personal data',
                                                textColor: Colors.white,
                                                fontSize: 14,
                                              )),
                                            ),
                                          ),
                                        );
                                }),
                              ],
                            ),
                          ),
                        )),
                  ]),
                );
    });
  }

  // function to setValues
  void setValues() {
    AppConstants.totalPrice = controller.state.totalPrice.value;
    AppConstants.vehicleType = carType;

    // condition for getting vehicle
    if (controller.state.vehicle_pickup.value == true) {
      AppConstants.isPickup = true;
      AppConstants.isDeliver = false;
    } else {
      AppConstants.isPickup = false;
      AppConstants.isDeliver = true;
    }
    // condition for extra miles and driving license
    if (controller.state.extraSwitchVal.value == true) {
      AppConstants.unlimitedMiles = true;
    } else {
      AppConstants.unlimitedMiles = false;
    }
    if (controller.state.driversCheckBoxVal.value == true) {
      AppConstants.under25Years = true;
    } else {
      AppConstants.under25Years = false;
    }
    //coverage conditions
    if (controller.state.standard_protection.value == true) {
      AppConstants.standardProtection = true;
    } else {
      AppConstants.standardProtection = false;
    }

    if (controller.state.essential_protection.value == true) {
      AppConstants.liabilityProtection = true;
    } else {
      AppConstants.liabilityProtection = false;
    }
    if (controller.state.i_have_own.value == true) {
      AppConstants.i_have_own = true;
    } else {
      AppConstants.i_have_own = false;
    }

    //customCoverageConditions
    if (controller.state.customCoverage == true) {
      AppConstants.customCoverage = true;
      if (controller.state.cdwSwitchVal.value == true) {
        controller.addInTotalCustomCoverageValue(controller.state.CDW!);
      }
      if (controller.state.rcliSwitchVal.value == true) {
        controller.addInTotalCustomCoverageValue(controller.state.RCLI!);
      }
      if (controller.state.assistanceVal.value == true) {
        controller.addInTotalCustomCoverageValue(controller.state.assistance!);
      }
      if (controller.state.sliSwitchVal.value == true) {
        controller.addInTotalCustomCoverageValue(controller.state.SLI!);
      }
    } else {
      AppConstants.customCoverage = false;
      AppConstants.totalCustomCoverage = 0.0;
    }

    AppConstants.bookingDate = DateTime.now().millisecondsSinceEpoch.toString();
  }
}

Widget _switchButton(
    bool val, ValueChanged<bool>? onChanged, BuildContext context) {
  return Switch(
    inactiveThumbColor: Theme.of(context).lightTextColor,
    inactiveTrackColor: Colors.transparent,
    activeColor: Theme.of(context).scaffoldBgClr,
    activeTrackColor: AppColors.buttonColor,
    value: val,
    onChanged: (value) {
      onChanged?.call(value);
    },
  );
}

Widget _checkBox(
    bool val, ValueChanged<bool>? onChanged, BuildContext context) {
  return Checkbox(
      shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: Colors.grey.withOpacity(.1), width: .5)),
      visualDensity: VisualDensity.compact,
      value: val,
      onChanged: (bool? value) {
        onChanged?.call(value!);
      });
}

Widget paymentCard(
    String cardImage, BuildContext context, CheckOutCon controller) {
  return InkWell(
    onTap: () {
      CardBottomSheet(context, true, controller);
    },
    child: Container(
      // height: mq.height*0.2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 60,
            height: 60,
            color: Theme.of(context).scaffoldBgClr,
            child: Image.asset('assets/appImages/${cardImage}'),
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            "****************",
            style: TextStyle(
              color: Theme.of(context).headingColor,
            ),
          ),
          SizedBox(
            width: 5,
          ),
        ],
      ),
    ),
  );
}
