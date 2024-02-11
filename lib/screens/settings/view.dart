import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ionicons/ionicons.dart';
import 'package:yb_ride/components/heading_text_widget.dart';
import 'package:yb_ride/components/snackbar_widget.dart';
import 'package:yb_ride/components/text_widget.dart';
import 'package:yb_ride/helper/app_colors.dart';
import 'package:yb_ride/screens/settings/pages/faqs/faq_bottom_sheet.dart';
import 'package:yb_ride/screens/settings/pages/faqs/view.dart';
import 'package:yb_ride/screens/settings/pages/payment_method/view.dart';
import 'package:yb_ride/routes/routes_name.dart';
import 'package:yb_ride/screens/onBoarding/inded.dart';
import 'package:yb_ride/screens/settings/controller.dart';
import 'package:yb_ride/screens/settings/pages/prefrences/inded.dart';
import 'package:yb_ride/screens/settings/pages/privacy_policy/view.dart';
import 'package:yb_ride/screens/settings/pages/profile/view.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:yb_ride/screens/settings/pages/termsAndServices/view.dart';
import '../../components/custom_Appbar.dart';
import '../../helper/session_controller.dart';
import '../../main.dart';
import 'package:get/get.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBgClr,

      appBar: PreferredSize(
        preferredSize: Size.fromHeight(mq.height * .08),
        child: CustomAppBarWidget(
          centerTitle: 'Settings',
          isLeading: false,
        ),
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
                HeadingTextWidget(
                  title: 'Account',
                  textColor: Theme.of(context).headingColor,
                ),
                SizedBox(
                  height: mq.height * .02,
                ),
                _buildListTile('Profile', Icons.person, Icons.arrow_forward_ios,
                    () {
                  PersistentNavBarNavigator.pushNewScreen(context,
                      screen: ProfileScreen(), withNavBar: true);
                },context),
                SizedBox(
                  height: mq.height * .02,
                ),


                _buildListTile('Referral Credits', FontAwesomeIcons.wallet,
                    Icons.arrow_forward_ios, () {
                  PersistentNavBarNavigator.pushNewScreen(context,
                      screen: PaymentScreen(), withNavBar: true);
                },context),
                SizedBox(
                  height: mq.height * .02,
                ),
                _buildListTile('Preferences', FontAwesomeIcons.gear,
                    Icons.arrow_forward_ios, () {
                  PersistentNavBarNavigator.pushNewScreen(context,
                      screen: PreferenceScreen(), withNavBar: true);
                },context),
                SizedBox(
                  height: mq.height * .02,
                ),
                Divider(),
                SizedBox(
                  height: mq.height * .02,
                ),
                HeadingTextWidget(
                    title: 'Help', textColor: Theme.of(context).headingColor),
                SizedBox(
                  height: mq.height * .02,
                ),
                _buildListTile(
                    'How YBCar works',
                    FontAwesomeIcons.circleQuestion,
                    Icons.arrow_forward_ios, () {
                  Get.to(
                    OnBoardingScreen(isOnboarding: false),
                    transition: Transition.downToUp,
                    duration: Duration(milliseconds: 500),
                  );
                },context),
                SizedBox(
                  height: mq.height * .02,
                ),
                _buildListTile('FAQ', FontAwesomeIcons.book,
                    Icons.arrow_forward_ios, () {
                      Get.to(()=>FAQScreen());


                    },context),
                SizedBox(
                  height: mq.height * .02,
                ),
                Divider(),
                SizedBox(
                  height: mq.height * .04,
                ),
                HeadingTextWidget(
                    title: 'Social', textColor: Theme.of(context).headingColor),
                SizedBox(
                  height: mq.height * .02,
                ),
                _buildListTile('Follow us on Instagram',
                    Ionicons.logo_instagram, Icons.arrow_forward_ios, () {
                  controller.launchInstagram();
                },context),
                SizedBox(
                  height: mq.height * .02,
                ),
                _buildListTile('Follow us on Twitter', FontAwesomeIcons.twitter,
                    Icons.arrow_forward_ios, () {
                  controller.launchTwitter();
                    },context),
                SizedBox(
                  height: mq.height * .02,
                ),
                Divider(),
                SizedBox(
                  height: mq.height * .04,
                ),
                HeadingTextWidget(
                    title: 'Partnerships', textColor: Theme.of(context).headingColor),
                SizedBox(
                  height: mq.height * .02,
                ),
                _buildListTile(
                    'Become a YBCar Surfer',
                    FontAwesomeIcons.personSnowboarding,
                    Icons.arrow_forward_ios,
                    () {
                      Get.toNamed(RoutesName.surferScreen);
                    },context),
                SizedBox(
                  height: mq.height * .02,
                ),
                _buildListTile(
                    'Partner with us',
                    FontAwesomeIcons.handshakeSimple,
                    Icons.arrow_forward_ios,
                    () {},context),
                SizedBox(
                  height: mq.height * .02,
                ),
                Divider(),
                SizedBox(
                  height: mq.height * .04,
                ),
                HeadingTextWidget(
                    title: 'Legal', textColor: Theme.of(context).lightTextColor),
                SizedBox(
                  height: mq.height * .02,
                ),
                _buildListTile(
                    'Terms of service',
                    FontAwesomeIcons.bookBookmark,
                    Icons.arrow_forward_ios,
                    () {
                      Get.to(TermsAndServices());
                    },context),
                SizedBox(
                  height: mq.height * .02,
                ),
                _buildListTile('Privacy Policy', FontAwesomeIcons.shieldHalved,
                    Icons.arrow_forward_ios, () {
                      Get.to(PrivacyPolicy());

                    },context),
                SizedBox(
                  height: mq.height * .02,
                ),
                Divider(),
                SizedBox(
                  height: mq.height * .04,
                ),
                HeadingTextWidget(
                    title: 'Rate Our App', textColor: Theme.of(context).headingColor),
                SizedBox(
                  height: mq.height * .03,
                ),
                InkWell(
                  onTap: () async {
                    try{
                      await FirebaseAuth.instance.signOut().then((value) {
                        GoogleSignIn().signOut().then((value){
                          SessionController().userId = '';
                        });
                        SessionController().userId = '';
                        Get.offAllNamed(RoutesName.loginScreen);
                      });
                    }catch(e){
                      Snackbar.showSnackBar("YB-Ride", e.toString(), Icons.error_outline);
                    }
                  },
                  child: HeadingTextWidget(
                    title: 'Log out',
                    textColor: AppColors.orangeColor,
                  ),
                ),
                SizedBox(
                  height: mq.height * .06,
                ),
                Center(
                  child: SubHeadingTextWidget(
                      title: "YBRide VERSION 1.0",
                      fontWeight: FontWeight.w600,
                      textColor: Theme.of(context).lightTextColor),
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

  Widget _buildListTile(String title, IconData leadingIcon,
      IconData trailingIcon, VoidCallback onPress,BuildContext context) {
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
                  FaIcon(
                    leadingIcon,
                    size: 15,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  SubHeadingTextWidget(
                    title: title,
                    fontWeight: FontWeight.w600,
                    textColor: Theme.of(context).lightTextColor,
                    fontSize: 15,
                  ),
                ],
              ),
              Icon(
                trailingIcon,
                color: AppColors.settingsIconColor,
                size: 11,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
