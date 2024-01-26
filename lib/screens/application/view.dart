import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:yb_ride/helper/app_colors.dart';
import 'package:yb_ride/screens/application/controller.dart';
import 'package:yb_ride/screens/pages/book_page/inded.dart';

class ApplicationView extends GetView<ApplicationViewController> {
  const ApplicationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BookNowView(),
      bottomNavigationBar: Container(
        height: 70,
        child: BottomNavigationBar(
          backgroundColor: Colors.grey.shade100,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.buttonColor,
          items: [
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
              icon: Icon(Icons.person),
              label: 'Invite',
            ),
            BottomNavigationBarItem(
              icon: Icon(Ionicons.settings),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }

  Widget returnNavBarIcon(IconData icon) {
    return CircleAvatar(
      radius: 15,
      backgroundColor: AppColors.whiteColor,
      child: Icon(
        Icons.home,
        size: 23,
      ),
    );
  }
}
