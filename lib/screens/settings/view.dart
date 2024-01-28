import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ionicons/ionicons.dart';
import 'package:yb_ride/components/heading_text_widget.dart';
import 'package:yb_ride/components/text_widget.dart';
import 'package:yb_ride/helper/app_colors.dart';
import 'package:yb_ride/screens/settings/pages/payment_method/view.dart';
import 'package:yb_ride/screens/settings/pages/profile/view.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../components/custom_Appbar.dart';
import '../../main.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(mq.height * .08),
        child: CustomAppBarWidget(centerTitle: 'Settings', isLeading: false,),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: mq.width * .04),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: mq.height * .03,
                ),
                HeadingTextWidget(title: 'Account'),
                SizedBox(
                  height: mq.height * .02,
                ),
                _buildListTile('Profile', Icons.person, Icons.arrow_forward_ios,(){
                  PersistentNavBarNavigator.pushNewScreen(context, screen: ProfileScreen(),withNavBar: true);
                }),
                SizedBox(
                  height: mq.height * .02,
                ),
                _buildListTile('Saved payment methods', FontAwesomeIcons.wallet, Icons.arrow_forward_ios,(){
                  PersistentNavBarNavigator.pushNewScreen(context, screen: PaymentScreen(),withNavBar: true);
                }),
                SizedBox(
                  height: mq.height * .02,
                ),
                _buildListTile('Preferences', FontAwesomeIcons.gear, Icons.arrow_forward_ios,(){}),
                SizedBox(
                  height: mq.height * .02,
                ),
                Divider(),
                SizedBox(
                  height: mq.height * .02,
                ),
                HeadingTextWidget(title: 'Help'),
                SizedBox(
                  height: mq.height * .02,
                ),
                _buildListTile('How YBCar works', FontAwesomeIcons.circleQuestion, Icons.arrow_forward_ios,(){}),
                SizedBox(
                  height: mq.height * .02,
                ),
                _buildListTile('FAQ', FontAwesomeIcons.book, Icons.arrow_forward_ios,(){}),
                SizedBox(
                  height: mq.height * .02,
                ),
                Divider(),
                SizedBox(
                  height: mq.height * .04,
                ),
                HeadingTextWidget(title: 'Social'),
                SizedBox(
                  height: mq.height * .02,
                ),
                _buildListTile('Follow us on Instagram', Ionicons.logo_instagram, Icons.arrow_forward_ios,(){}),
                SizedBox(
                  height: mq.height * .02,
                ),
                _buildListTile('Follow us on Twitter', FontAwesomeIcons.twitter, Icons.arrow_forward_ios,(){}),
                SizedBox(
                  height: mq.height * .02,
                ),
                Divider(),
                SizedBox(
                  height: mq.height * .04,
                ),
                HeadingTextWidget(title: 'Partnerships'),
                SizedBox(
                  height: mq.height * .02,
                ),
                _buildListTile('Become a YBCar Surfer', FontAwesomeIcons.personSnowboarding, Icons.arrow_forward_ios,(){}),
                SizedBox(
                  height: mq.height * .02,
                ),
                _buildListTile('Partner with us', FontAwesomeIcons.handshakeSimple, Icons.arrow_forward_ios,(){}),
                SizedBox(
                  height: mq.height * .02,
                ),
                Divider(),

                SizedBox(
                  height: mq.height * .04,
                ),
                HeadingTextWidget(title: 'Legal'),
                SizedBox(
                  height: mq.height * .02,
                ),
                _buildListTile('Terms of service', FontAwesomeIcons.bookBookmark, Icons.arrow_forward_ios,(){}),
                SizedBox(
                  height: mq.height * .02,
                ),
                _buildListTile('Privacy Policy', FontAwesomeIcons.shieldHalved, Icons.arrow_forward_ios,(){}),
                SizedBox(
                  height: mq.height * .02,
                ),
                Divider(),
                SizedBox(
                  height: mq.height * .04,
                ),
                HeadingTextWidget(title: 'Rate Our App'),
                SizedBox(
                  height: mq.height * .03,
                ),
                HeadingTextWidget(title: 'Log out' , textColor: AppColors.orangeColor,),
                SizedBox(
                  height: mq.height * .06,
                ),
                Center(
                  child: SubHeadingTextWidget(
                    title: "YBRide VERSION 1.0",
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: mq.height * .04,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildListTile (String title, IconData leadingIcon , IconData trailingIcon,VoidCallback onPress) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: mq.width * .005),
      child: InkWell(
        onTap: onPress,
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  // Icon(leadingIcon,size: 20,),
                  FaIcon(leadingIcon , size: 15,),
                  SizedBox(
                    width: 15,

                  ),
                  SubHeadingTextWidget(title: title,fontWeight: FontWeight.w600,fontSize: 15,),
                ],
              ),
              Icon(trailingIcon,color: AppColors.settingsIconColor,size: 11,),

            ],
          ),
        ),
      ),
    );
  }
}
