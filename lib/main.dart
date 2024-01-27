import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yb_ride/helper/app_colors.dart';
import 'package:yb_ride/routes/app_routes.dart';
import 'package:yb_ride/routes/routes_name.dart';
import 'firebase_options.dart';
late Size mq;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.sizeOf(context);
    return GetMaterialApp(
      title: 'Flutter Demo',
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

      // home: OnBoardingScreen(
      //   // backgroundColor: Colors.white,
      //   // appBar: PreferredSize(
      //   //   preferredSize: Size.fromHeight(mq.height * 0.04),
      //   //   child:  CustomAppBarWidget(
      //   //     centerTitle: 'AppBar',
      //   //   ),
      //   // ),
      // ),

      initialRoute: RoutesName.welcomeScreen,
      getPages: AppRoutes.routes,
    );

  }
}
