import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:yb_ride/components/heading_text_widget.dart';
import 'package:yb_ride/helper/app_colors.dart';
import 'package:yb_ride/screens/pages/trips_page/trip_pages/sharedTrips/controller.dart';

import '../../../../../components/reuseable_button.dart';
import '../../../../../components/text_widget.dart';
import '../../../../../main.dart';
import '../../../../application/controller.dart';
import '../../../book_page/view.dart';

class SharedTripsView extends GetView<SharedTripController> {
  const SharedTripsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Spacer(),
          Container(
            height: mq.height * 0.4,
            width: mq.width * .95,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              border: Border.all(
                color: Colors.grey,
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: mq.height * .06,
                ),
                Container(
                  height: mq.height * .05,
                  width: mq.height * .05,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Icon(
                    Icons.share_location_rounded,
                    color: AppColors.iconColor,
                    size: 40,
                  ),
                ),
                SizedBox(
                  height: mq.height * .04,
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
                        "Trips, where you have accepted and invite to be an additional driver, will show up here!",
                        fontWeight: FontWeight.w600,
                        textColor: Theme.of(context).lightTextColor,
                        fontSize: 15,
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
                      title:'Book a YBCar',
                      onPress: () {
                        final con = Get.put(ApplicationViewController());
                        // con.state.currentNavIndex.value = 0;
                        con.changeTab(0);
                      }),
                ),

              ],
            ),
          ),
          Spacer(
            flex: 2,
          ),
        ],
      ),
    );
  }
}
