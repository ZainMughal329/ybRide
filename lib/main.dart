import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yb_ride/helper/app_colors.dart';
import 'package:yb_ride/helper/app_constants.dart';
import 'package:yb_ride/helper/prefs.dart';
import 'package:yb_ride/routes/app_routes.dart';
import 'package:yb_ride/routes/routes_name.dart';
import 'package:yb_ride/screens/settings/pages/faqs/view.dart';
import 'package:yb_ride/screens/settings/pages/prefrences/apperence/controller.dart';
import 'firebase_options.dart';
import 'helper/app_theme.dart';
import 'helper/notification_services.dart';
late Size mq;
late bool isDarkTheme;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Stripe.publishableKey = AppConstants.stripe_publish_key;
  // Stripe.merchantIdentifier = 'merchant.flutter.stripe.test';
  // Stripe.urlScheme = 'flutterstripe';await Stripe.instance.applySettings();
  // await Stripe.instance.applySettings();
  Stripe.publishableKey = AppConstants.stripe_publish_key;
  Pref.init();
  Pref.initialize();

  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  NotificationServices().requestPermissions();
  NotificationServices().setupBackgrounInteractMsg();
  NotificationServices().initFirebase();
  NotificationServices().getToken().then((value) {
    log('Device Token');
    log(value);
  });

  // run app function


  runApp(const MyApp());


}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.sizeOf(context);
    return GetMaterialApp(
      title: 'YB Ride',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        appBarTheme: AppBarTheme(
          elevation: 3,
          centerTitle: false,
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          shadowColor: Colors.black54,
          titleTextStyle: GoogleFonts.openSans(
            color: AppColors.headingColor,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      darkTheme: ThemeData.dark(),
      themeMode: Pref.defaultTheme(),
      // home: FAQScreen(),
      initialRoute: RoutesName.splashScreen,

      getPages: AppRoutes.routes,
    );
  }
}


extension AppTheme on ThemeData {

  Color get lightTextColor => brightness == Brightness.dark ? Colors.white70 : Color(0xff606060);

  Color get headingColor => brightness == Brightness.dark ? Colors.white : Colors.black;

  Color get appBarColor => brightness == Brightness.dark ? Colors.grey.shade900 : Colors.white;

  Color get nonActiveTextFieldColor => brightness == Brightness.dark ? Colors.white : Colors.black;

  Color get detailsIconColor => brightness == Brightness.dark ? Colors.white : Colors.black;

  Color get navBarColor => brightness == Brightness.dark ? Colors.grey.shade900 : Colors.white;

  Color get scaffoldBgClr => brightness == Brightness.dark ? Colors.grey.shade900 : Colors.white;

  Color get cardBgClr => brightness == Brightness.dark ? Colors.grey.shade900 : Colors.white;

}