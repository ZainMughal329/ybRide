import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';

import 'dart:io';


import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yb_ride/helper/app_colors.dart';
import 'package:yb_ride/helper/app_constants.dart';
import 'package:yb_ride/helper/prefs.dart';
import 'package:yb_ride/routes/app_routes.dart';
import 'package:yb_ride/routes/routes_name.dart';
import 'firebase_options.dart';
import 'helper/app_theme.dart';
import 'helper/notification_services.dart';
import 'package:permission_handler/permission_handler.dart';

late Size mq;
late bool isDarkTheme;




@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage remoteMessage) async {
  await Firebase.initializeApp();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(

    options: Platform.isAndroid?FirebaseOptions(
      apiKey: 'AIzaSyD6qyZHi0zLgP091Zs8Pu4aDHucLT4ofXI',
      appId: '1:782774219638:android:0c4461b6608a5a880e4057',
      messagingSenderId: '782774219638',
      projectId: 'yb-ride-83505',
      storageBucket: 'yb-ride-83505.appspot.com',
      androidClientId: '782774219638-q425s01mtjnn15ve7kscer8nh6futvj5.apps.googleusercontent.com',
      iosClientId: '782774219638-bq3vp1ov0d6vjpc2vc91aep17f9gk18g.apps.googleusercontent.com',
      iosBundleId: 'com.dev.ybride',
    ): FirebaseOptions(
      apiKey: 'AIzaSyD3_51intphkkZskb4ta-oACx5Kt8ZCgxQ',
      appId: '1:782774219638:ios:5a98e9631c575dea0e4057',
      messagingSenderId: '782774219638',
      projectId: 'yb-ride-83505',
      storageBucket: 'yb-ride-83505.appspot.com',
      androidClientId: '782774219638-09p6k5p450h4nlvvfqtsvanj9tam41g2.apps.googleusercontent.com',
      iosClientId: '782774219638-bq3vp1ov0d6vjpc2vc91aep17f9gk18g.apps.googleusercontent.com',
      iosBundleId: 'com.dev.ybride',
    )
  );
  // Pref.init();
  Pref.initialize();
  Stripe.publishableKey =
  'pk_live_51PGJESBOId3miMVo61uIisHvhZ1EA3VlfUHhraMJILZ9ZrU56rAJ4XxPuFILHvFoohDdBF76UBhJGpaOMqYGw9GP00W9EhCUAi';
  Stripe.merchantIdentifier = 'YB Ride';
  Stripe.urlScheme = 'flutterstripe';
  await Stripe.instance.applySettings(

  );
  await dotenv.load(fileName: "assets/.env");
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]
  );


  await Permission.locationWhenInUse.isDenied.then((valueOfPermission)
  {
    if(valueOfPermission)
    {
      Permission.locationWhenInUse.request();
    }
  });

  NotificationServices().requestPermissions();
  NotificationServices().setupBackgroundInteractMsg();
  NotificationServices().foregroundMessage();
  NotificationServices().initFirebase();
  NotificationServices().getToken().then((value) {
  });

  // run app function


  runApp( MyApp());


}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.sizeOf(context);
    AppConstants.stripe_publish_key = dotenv.env['LIVE_STRIPE_PUBLISH_KEY']!;
    AppConstants.stripe_secret_key =  dotenv.env['LIVE_STRIPE_SECRET_KEY']!;

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
      // themeMode: Pref.defaultTheme(),
      // home: FAQScreen(),
      initialRoute: RoutesName.splashScreen,
      // home: SplashScreen(),
      // initialRoute: ,
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