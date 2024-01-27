import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:yb_ride/helper/app_colors.dart';
import 'package:yb_ride/screens/application/controller.dart';
import 'package:yb_ride/screens/pages/book_page/inded.dart';
import 'package:yb_ride/screens/pages/invite_page/inded.dart';
import 'package:yb_ride/screens/pages/trips_page/inded.dart';

import '../../main.dart';

class ApplicationView extends GetView<ApplicationViewController> {
  const ApplicationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var navbarItem = [
      BottomNavigationBarItem(
        icon: returnNavBarIcon(CupertinoIcons.car_detailed),
        label: 'Book',

      ),
      BottomNavigationBarItem(
        icon: returnNavBarIcon(Icons.route),
        label: 'Trips',
      ),
      BottomNavigationBarItem(
        icon: returnNavBarIcon(CupertinoIcons.gift),
        label: 'Help',
      ),
      BottomNavigationBarItem(
        icon: returnNavBarIcon(Icons.person),
        label: 'Invite',
      ),
      BottomNavigationBarItem(
        icon: returnNavBarIcon(Ionicons.settings),
        label: 'Settings',
      ),
    ];
    var navBody = [
      BookNowView(),
      TripScreen(),
      Scaffold(
        appBar: AppBar(
          title: Text('help'),
        ),
      ),
      InviteScreen(),
      Scaffold(
        appBar: AppBar(
          title: Text('settings'),
        ),
      ),
    ];

    return Scaffold(
      body: Column(
        children: [
          Obx(() => Expanded(
                child:
                    navBody.elementAt(controller.state.currentNavIndex.value),
              )),
        ],
      ),
      bottomNavigationBar: Obx(
        () => Container(
          height: mq.height * .11,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.25),
                spreadRadius: 1,
                blurRadius: 3,
                offset: Offset(0,-3),
              ),
            ],
          ),
          child: BottomNavigationBar(
            elevation: 2,
            backgroundColor: Colors.grey.shade100,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: AppColors.buttonColor,
            selectedLabelStyle: GoogleFonts.openSans(fontWeight: FontWeight.w800,color: AppColors.buttonColor),
            unselectedLabelStyle: GoogleFonts.openSans(fontWeight: FontWeight.w800,color: AppColors.buttonColor),
            unselectedItemColor: AppColors.buttonColor,
            currentIndex: controller.state.currentNavIndex.value,
            items: navbarItem,
            onTap: (value) {
              controller.state.currentNavIndex.value = value;
            },
          ),
        ),
      ),
    );
  }

  Widget returnNavBarIcon(IconData icon) {
    return CircleAvatar(
      radius: 15,
      backgroundColor: AppColors.whiteColor,
      child: Icon(
        icon,
        size: 18,
      ),
    );
  }
}
