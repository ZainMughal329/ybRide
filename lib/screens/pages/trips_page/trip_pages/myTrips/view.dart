import 'package:flutter/cupertino.dart';

import '../../../../../components/heading_text_widget.dart';
import '../../../../../components/reuseable_button.dart';
import '../../../../../components/text_widget.dart';
import '../../../../../helper/app_colors.dart';
import '../../../../../main.dart';

class MyTripsView extends StatelessWidget {
  const MyTripsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: mq.height * .08,
          ),
          Padding(
            padding: EdgeInsets.only(top: mq.height * .09),
            child: Image(
                image: AssetImage(
                    'assets/images/trips.jpeg'),
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
                  // Get.toNamed(RoutesName.inviteScreen);
                }),
          ),
          SizedBox(
            height: mq.height * .04,
          ),


        ],
      ),
    );
  }
}
