import 'package:card_swiper/card_swiper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:yb_ride/components/custom_Appbar.dart';
import 'package:yb_ride/components/heading_text_widget.dart';
import 'package:yb_ride/components/text_widget.dart';
import 'package:yb_ride/helper/app_colors.dart';
import 'package:yb_ride/helper/app_constants.dart';
import 'package:yb_ride/routes/routes_name.dart';
import 'package:yb_ride/screens/pages/Checkout/index.dart';
import 'package:yb_ride/screens/pages/book_page/car_details/inded.dart';
import 'package:yb_ride/screens/pages/book_page/car_details/widgets/details_sheet.dart';
import 'package:yb_ride/screens/splash/controller.dart';

import '../../../../main.dart';
import '../controller.dart';
import '../widget/1st_bottom_sheet.dart';

class CarDetailsScreen extends GetView<CarDetailsController> {
  final bool isTextShow;
  CarDetailsScreen({Key? key, required this.isTextShow}) : super(key: key);
  final controller = Get.put(CarDetailsController());

  @override
  Widget build(BuildContext context) {
    double notchHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBgClr,
      appBar: PreferredSize(
        preferredSize: isTextShow
            ? Size.fromHeight(mq.height * .08)
            : Size.fromHeight(mq.height * .1),
        child: isTextShow
            ? CustomAppBarWidget(
                centerTitle: 'Change Car',
                isLeading: true,
                leadingIcon: FontAwesomeIcons.xmark,
                leadingPress: () {
                  Navigator.pop(context);
                },
              )
            : Padding(
                padding: EdgeInsets.only(top: notchHeight + 5),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .appBarColor, // Set your preferred background color
                    boxShadow: [
                      BoxShadow(
                        color:
                            Colors.black.withOpacity(0.2), // Set shadow color
                        blurRadius: 4, // Set the blur radius for the 3D effect
                        offset: Offset(0, 2), // Set the offset for the shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(
                            FontAwesomeIcons.xmark,
                            size: 18,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        InkWell(
                          onTap: () {
                            final bookcontr = Get.put(BookViewController());
                            firstBottomSheet(context, bookcontr);
                          },
                          child: Center(
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 12.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        'Boston',
                                        style: GoogleFonts.openSans(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18,
                                          color: AppColors.buttonColor,
                                        ),
                                      ),
                                      Text(
                                        '${AppConstants.fromMonthName} ${AppConstants.fromDate} - ${AppConstants.toMonthName} ${AppConstants.toDate}',
                                        style: GoogleFonts.openSans(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                          color: AppColors.buttonColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 10.0),
                                  child: Icon(
                                    Icons.arrow_drop_down,
                                    size: 18,
                                    color: AppColors.buttonColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(),
                      ],
                    ),
                  ),
                ),
              ),
      ),
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.only(left:mq.width*0.03,top:mq.width*0.01,right:mq.width*0.03),
          child: StreamBuilder(
            stream: controller.state.vehicleRef,
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if(snapshot.hasData){
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index){
                    return _buildCARCard(context, snapshot.data!.docs[index]);
                  },);
              }else{
               return Container(
                 child: Lottie.asset('assets/lottie/loading2.json',width: 200,height: 200),
               ); 
              }
            },
          ),
        ),
        // child: ListView.builder(
        //   itemCount: 5,
        //   physics: BouncingScrollPhysics(),
        //   itemBuilder: (context, index) {
        //     return Padding(
        //       padding: EdgeInsets.all(mq.height * .035),
        //       child: _buildCARCard(context),
        //     );
        //   },
        // ),
      ),
    );
  }

  Widget _buildCARCard(BuildContext context,docData) {
    String carType = docData['type'];
    print(carType);
    return Padding(
      padding: EdgeInsets.only(bottom: 5),
      child: InkWell(
        onTap: () {
      // controller.calculateNoDays();
          controller.state.rentPerDay = docData['pricePerDay'];
          controller.calculateNoDays();
          Get.to(() => CheckOutScreen(
              carRent: controller.state.rentPerDay * AppConstants.rentDays));
          // Get.toNamed(RoutesName.checkOutScreen,arguments: {'',controller.state.rentPerDay});
        },
        child: Container(
          // height: mq.height * .38,
          width: double.infinity,
          child: Column(
            children: [
              Container(
                height: mq.height * .23,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  // color: Colors.red,
                  border: Border.all(color: Colors.black12),
                ),
                child: Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    return Image.asset(
                      carType == "SUV"
                          ? controller.seaterList[index]
                          : carType == "AllWheelDriveSUV"
                              ? controller.awdList[index]
                              : carType == "Economy"
                                  ? controller.ecoList[index]
                                  : carType == "Premium"
                                      ? controller.premimumList[index]
                                      : controller.sedanList[index],
                      fit: BoxFit.cover,
                      // height: 188.h,
                      width: mq.width * .288,
                    );
                  },
                  autoplay: false,
                  itemCount: 3,
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
                height: mq.height * .01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  HeadingTextWidget(
                    title: docData['type'],
                    textColor: Theme.of(context).headingColor,
                  ),
                  InkWell(
                    onTap: () {
                      detailsBottomSheet(context);
                    },
                    child: SubHeadingTextWidget(
                      title: 'See details',
                      fontWeight: FontWeight.w600,
                      textColor: AppColors.buttonColor,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: mq.height * .01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SubHeadingTextWidget(
                        title: docData['type'],
                        textColor: Theme.of(context).headingColor,
                      ),
                      SubHeadingTextWidget(
                        title: '${docData['seats']} seats . ${docData['suitcase']} suitcase',
                        textColor: Theme.of(context).lightTextColor,
                      ),
                      SizedBox(
                        height: mq.height * .015,
                      ),
                      HeadingTextWidget(
                        // title: '\$${controller.state.rentPerDay} | day',
                        title: '\$${docData['pricePerDay']} | day',
                        textColor: Theme.of(context).headingColor,
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: mq.height * .06),
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 1),
                        child: Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.stopwatch,
                              color: Colors.blue,
                              size: 18,
                            ),
                            SizedBox(
                              width: mq.width * .015,
                            ),
                            HeadingTextWidget(
                              title: '${docData['noOfVehicles']} vehicles left',
                              textColor: Colors.blue,
                              fontSize: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: mq.height * .02,
              ),
              Divider(
                color: AppColors.dotColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
