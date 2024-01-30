


import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:yb_ride/components/custom_Appbar.dart';
import 'package:yb_ride/routes/app_routes.dart';
import 'package:yb_ride/screens/application/inded.dart';
import 'package:yb_ride/screens/pages/book_page/inded.dart';
import '../../../components/heading_text_widget.dart';
import '../../../components/reuseable_button.dart';
import '../../../components/text_widget.dart';
import '../../../helper/app_colors.dart';
import '../../../main.dart';
import '../../../routes/routes_name.dart';
import 'controller.dart';

class InviteScreen extends GetView<InviteCon> {
  const InviteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    final subtittle="They get a YBRide \$30.00 discount on their first booking and you earn \$30.00 in YBride credits. Yours code will be created after you first booking.";
    mq = MediaQuery.sizeOf(context);

    return Scaffold(
        appBar: PreferredSize(preferredSize: Size.fromHeight(mq.height* .08), child:CustomAppBarWidget(centerTitle: 'Invite friends',isLeading: false,) ),
        body: Column(
          children: [
            SizedBox(
              height: mq.height * .06,
            ),
            Padding(
              padding: EdgeInsets.only(top: mq.height * .09),
              child: Image(
                  image: AssetImage(
                      'assets/images/6.jpeg'),
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
                  title:'Invite your friends',
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
                    title: subtittle,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    maxLines:5,
                    textColor: Theme.of(context).lightTextColor,
                    overflow: TextOverflow.ellipsis,
                  )),
            ),
            SizedBox(
              height: mq.height * .02,
            ),
            Center(
              child: SizedBox(
                width: mq.width * .9,
                child: HeadingTextWidget(
                  fontSize:  14,
                  textColor: AppColors.buttonColor,
                  fontWeight: FontWeight.w600,
                  textAlign: TextAlign.center,
                  title:'Information about Referrals',
                ),
              ),
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

          ],
        )
    );
  }
}
