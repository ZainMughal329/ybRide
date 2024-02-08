import 'dart:developer';

import 'package:card_swiper/card_swiper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:yb_ride/helper/session_controller.dart';
import 'package:yb_ride/screens/pages/trips_page/trip_pages/myTrips/controller.dart';
import 'package:yb_ride/screens/pages/trips_page/trip_pages/myTrips/widgets/view.dart';

import '../../../../../api/api.dart';
import '../../../../../components/heading_text_widget.dart';
import '../../../../../components/reuseable_button.dart';
import '../../../../../components/text_widget.dart';
import '../../../../../helper/app_colors.dart';
import '../../../../../main.dart';
import '../../../../application/controller.dart';
import '../../../book_page/view.dart';

class MyTripsView extends StatelessWidget {
  MyTripsView({super.key});


  List<String> economyList = [
    'assets/carImages/eco-1.png',
    'assets/carImages/eco-2.png',
    'assets/carImages/eco-3.png',
  ];

  List<String> premiumList = [
    'assets/carImages/premium-1.png',
    'assets/carImages/premium-2.png',
    'assets/carImages/premium-3.png',
  ];

  List<String> sedanList = [
    'assets/carImages/sedan-1.png',
    'assets/carImages/sedan-2.png',
    'assets/carImages/sedan-3.png',
  ];


  List<String> avdList = [
    'assets/carImages/awd-1.png',
    'assets/carImages/awd-2.png',
    'assets/carImages/awd-3.png',
  ];
  List<String> suvList = [
    'assets/carImages/7_seater-1.png',
    'assets/carImages/7_seater-2.png',
    'assets/carImages/7_seater-3.png',
  ];

  @override
  Widget build(BuildContext context) {
    final cont = MyTripController();
    return Container(
      child: StreamBuilder<QuerySnapshot>(
        stream:APis.db.collection('all_bookings').
        // where('id' , isEqualTo: SessionController().userId.toString()).
        snapshots(),
        builder: (context , AsyncSnapshot<QuerySnapshot> snapshot) {
          if(!snapshot.hasData){
            return Center(
              child: Container(
                height: 100,
                width: 100,
                child: Lottie.asset('assets/lottie/loading2.json'),
              ),
            );
          }
          var data = snapshot.data!.docs;

          log('length:'+data.length.toString());
          return data.length !=0 ?
              ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context , index) {
                    var fromDateString =
                    data[index]['fromDateEpoch']
                    as String;
                    log('from:$fromDateString');
                    var fromDateMillis =
                    int.parse(fromDateString);
                    var fromDate = DateTime
                        .fromMillisecondsSinceEpoch(
                        fromDateMillis);
                    var fromFormattedDate =
                    DateFormat.yMd().format(
                        fromDate.toLocal());
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: mq.width * .9,
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBgClr,
                      border: Border.all(
                        color: AppColors.buttonColor,
                        width: 0.2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).headingColor.withOpacity(.1),
                          blurRadius: 5,
                          spreadRadius: 1,
                          offset: Offset(1, 1),
                        ),
                      ],
                    ),

                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Center(
                        child: Container(
                          width: 350,
                          // height: 350,
                          child: Column(
                            children: [
                              Column(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        height: 150,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          // borderRadius: BorderRadius.circular(10),
                                          // color: Colors.red,
                                          // border: Border.all(color: Colors.black12),
                                        ),
                                        child: Swiper(
                                          itemBuilder: (BuildContext context, int ind) {
                                            return Image.asset(
                                              data[index]['vehicleType'] == "Premium"? premiumList[ind] : data[index]['vehicleType'] == "Economy"? economyList[ind] : data[index]['vehicleType'] == "AllWheelDriveSUV"? avdList[ind] : data[index]['vehicleType'] == "SUV"? suvList[ind] : sedanList[ind],
                                              fit: BoxFit.cover,
                                              // height: 188.h,
                                              width: 288,
                                            );
                                          },
                                          autoplay: false,
                                          itemCount: sedanList.length,
                                          viewportFraction: 0.8,
                                          scale: 0.9,
                                          pagination: SwiperPagination(
                                            alignment: Alignment.bottomCenter,
                                            builder: DotSwiperPaginationBuilder(
                                                color: Colors.black12,
                                                activeColor: Colors.white,
                                                activeSize: 13),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 20),
                                        child: Container(
                                          // height:220,
                                          width: 320,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  HeadingTextWidget(title: data[index]['vehicleType'],textColor: Theme.of(context).headingColor,),
                                                  InkWell(
                                                    onTap: ()
                                                    {
                                                      var rowData = data[index];
                                                      var fromDateString =
                                                      rowData['bookingDate']
                                                      as String;
                                                      log('from:$fromDateString');
                                                      var fromDateMillis =
                                                      int.parse(fromDateString);
                                                      var fromDate = DateTime
                                                          .fromMillisecondsSinceEpoch(
                                                          fromDateMillis);
                                                      var fromFormattedDate =
                                                      DateFormat.yMd().format(
                                                          fromDate.toLocal());

                                                      var toDateString =
                                                      rowData['toDateEpoch']
                                                      as String;
                                                      log('startDateString:$toDateString');
                                                      var toDateMillis =
                                                      int.parse(toDateString);
                                                      var toDate = DateTime
                                                          .fromMillisecondsSinceEpoch(
                                                          toDateMillis);
                                                      var toFormattedDate =
                                                      DateFormat.yMd()
                                                          .format(toDate.toLocal());

                                                      var fromTimeString =
                                                      rowData['fromTimeEpoch']
                                                      as String;
                                                      log('startDateString:$fromTimeString');
                                                      var fromTimeMillis =
                                                      int.parse(fromTimeString);
                                                      var fromTime = DateTime
                                                          .fromMillisecondsSinceEpoch(
                                                          fromTimeMillis);

                                                      var formattedTime =
                                                      DateFormat('h:mm a').format(
                                                          fromTime.toLocal());

                                                      var toTimeString =
                                                      rowData['toTimeEpoch']
                                                      as String;
                                                      log('startDateString:$toTimeString');
                                                      var toTimeMillis =
                                                      int.parse(toTimeString);
                                                      var toTime = DateTime
                                                          .fromMillisecondsSinceEpoch(
                                                          toTimeMillis);

                                                      var toFormattedTime =
                                                      DateFormat('h:mm a')
                                                          .format(toTime.toLocal());

                                                      showCustomAlertDialogTrips(
                                                        context,
                                                        rowData['fullName'],
                                                        rowData['email'],
                                                        rowData['phone'],
                                                        rowData['completeFromAddress'],
                                                        rowData['completeToAddress'],
                                                        fromFormattedDate,
                                                        toFormattedDate,
                                                        formattedTime,
                                                        toFormattedTime,
                                                        rowData['vehicleType'],
                                                        rowData['totalPrice'],
                                                        rowData['isPickUp'],
                                                        rowData['isDelivery'],
                                                        rowData['isStandardProtection'],
                                                        rowData[
                                                        'isLiabilityProtection'],
                                                        rowData['isIHaveOwnProtection'],
                                                        rowData['isCustomCoverage'],
                                                        rowData['totalCustomCoverage'],
                                                        rowData['isUnlimitedMiles'],
                                                        rowData['isUnder25years'],
                                                        rowData['isPromoCodeApplied'],
                                                        rowData['promoDiscountAmount'],
                                                      );
                                                    }
                                                    ,
                                                    child: Container(
                                                      height: 30,
                                                      width: 70,
                                                      decoration: BoxDecoration(
                                                        color: AppColors.buttonColor,
                                                        borderRadius: BorderRadius.circular(10),
                                                      ),
                                                      child: Center(
                                                        child: HeadingTextWidget(
                                                          title: 'Details',
                                                          fontSize: 13,
                                                          textColor: AppColors.whiteColor,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              SubHeadingTextWidget(
                                                title: 'Start Date:$fromFormattedDate',
                                                textColor: Theme.of(context).headingColor,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              SubHeadingTextWidget(
                                                  title:'Total Price' + data[index]['totalPrice'].toString(),textColor: Theme.of(context).headingColor,
                                                      ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              })
              :
          Column(
            children: [
              SizedBox(
                height: mq.height * .06,
              ),
              Padding(
                padding: EdgeInsets.only(top: mq.height * .09),
                child: Image(
                    image: AssetImage(
                        'assets/appImages/myTrips.png'),
                    height: mq.height * .3,
                    width: mq.width * .5),
              ),
              Center(
                child: SizedBox(
                  width: mq.width * .9,
                  child: HeadingTextWidget(
                    fontSize:  16,
                    fontWeight: FontWeight.w600,
                    textAlign: TextAlign.center,
                    textColor: Theme.of(context).headingColor,
                    title:'No trips (yet)',
                  ),
                ),
              ),
              SizedBox(
                height: mq.height * .02,
              ),
              Center(
                child: SizedBox(
                    width: mq.width * .8,
                    child: SubHeadingTextWidget(
                      textAlign: TextAlign.center,
                      title:
                      "You haven't booked YBCars yet. How about doing so for your next adventure?",
                      fontWeight: FontWeight.w600,
                      textColor: Theme.of(context).lightTextColor,
                      fontSize: 14,
                      maxLines:5,
                      overflow: TextOverflow.ellipsis,
                    )),
              ),
              SizedBox(
                height: mq.height * .02,
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: mq.width * .02, right: mq.width * .02),
                child: RoundButton(
                    title:'Book your YBCar now',
                    onPress: () {
                      final con = Get.put(ApplicationViewController());
                      // con.state.currentNavIndex.value = 0;
                      con.changeTab(0);




                    }),
              ),
              SizedBox(
                height: mq.height * .04,
              ),


            ],
          );
        },
      ),
    );
  }
}
