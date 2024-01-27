import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yb_ride/components/custom_Appbar.dart';
import 'package:yb_ride/screens/pages/trips_page/controller.dart';
import 'package:yb_ride/screens/pages/trips_page/trip_pages/myTrips/view.dart';
import 'package:yb_ride/screens/pages/trips_page/trip_pages/sharedTrips/view.dart';

import '../../../helper/app_colors.dart';
import '../../../main.dart';

class TripScreen extends GetView<TripController> {
  const TripScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(mq.height * .08),
        child: CustomAppBarWidget(centerTitle: 'Trips', isLeading: false,),
      ),
      body: SafeArea(child: Column(
        children: [
          Container(
            child: TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              tabAlignment:TabAlignment.fill,
              labelColor: AppColors.headingColor,
              indicatorColor: AppColors.buttonColor,
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(width: 2.0,color: AppColors.buttonColor), // Adjust the width of the line
              ),
              labelStyle: GoogleFonts.openSans(
                fontSize: 16.0, // Customize the font size
                fontWeight: FontWeight.w600,
              ),

              indicatorPadding: EdgeInsets.all(0),
              unselectedLabelColor: AppColors.headingColor,
              unselectedLabelStyle: GoogleFonts.openSans(
                fontSize: 16,
                fontWeight: FontWeight.w600,

              ),

              tabs: [

                Tab(
                  text: 'My Trips',
                ),
                Tab(
                  text: 'Shared Trips',

                ),

              ],
              controller: controller.tabController,
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              margin: EdgeInsets.only(top: 10),
              // height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: TabBarView(
                controller: controller.tabController,
                children: [
                  MyTripsView(),
                  SharedTripsView(),
                ],
              ),
            ),)
        ],
      )),
    );
  }
}
