import 'package:get/get.dart';
import 'package:yb_ride/routes/routes_name.dart';
import 'package:yb_ride/screens/application/inded.dart';
import 'package:yb_ride/screens/onBoarding/inded.dart';
import 'package:yb_ride/screens/pages/Checkout/bindings.dart';
import 'package:yb_ride/screens/pages/Checkout/view.dart';
import 'package:yb_ride/screens/pages/book_page/bindings.dart';
import 'package:yb_ride/screens/pages/book_page/car_details/inded.dart';
import 'package:yb_ride/screens/pages/book_page/inded.dart';
import 'package:yb_ride/screens/pages/help_page/bindings.dart';
import 'package:yb_ride/screens/pages/help_page/view.dart';
import 'package:yb_ride/screens/pages/invite_page/inded.dart';
import 'package:yb_ride/screens/session/login/inded.dart';
import 'package:yb_ride/screens/session/signUp/inded.dart';
import 'package:yb_ride/screens/session/welcome.dart';
import 'package:yb_ride/screens/settings/pages/payment_method/bindings.dart';
import 'package:yb_ride/screens/settings/pages/payment_method/view.dart';
import 'package:yb_ride/screens/settings/pages/prefrences/apperence/inded.dart';
import 'package:yb_ride/screens/settings/pages/prefrences/inded.dart';
import 'package:yb_ride/screens/settings/pages/ybcar_surfer/inded.dart';
import 'package:yb_ride/screens/splash/bindings.dart';
import 'package:yb_ride/screens/splash/view.dart';
import 'package:yb_ride/screens/settings/pages/profile/inded.dart';
class AppRoutes {
  static final List<GetPage> routes = [
    GetPage(
      name: RoutesName.splashScreen,
      page: () => SplashScreen(),
      binding: SplashBindings(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: RoutesName.onBoardingScreen,
      page: () => OnBoardingScreen(isOnboarding: true,),
      binding: onBoardingBindings(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: RoutesName.welcomeScreen,
      page: () => WelcomePage(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: RoutesName.loginScreen,
      page: () => LoginScreen(),
      binding: LoginBindings(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: RoutesName.signUpScreen,
      page: () => SignupScreen(),
      binding: SignUpBindings(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: RoutesName.bookNowScreen,
      page: () => BookNowView(),
      binding: BookViewBindings(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: RoutesName.applicationScreen,
      page: () => ApplicationView(),
      bindings: <Bindings>[
        ApplicationViewBindings(),
        BookViewBindings(),
      ],
      transition: Transition.downToUp,
    ),
    GetPage(
      name: RoutesName.inviteScreen,
      page: () => InviteScreen(),
      bindings: <Bindings>[
        InviteBindings(),
      ],
      transition: Transition.downToUp,
    ),
    GetPage(
      name: RoutesName.helpScreen,
      page: () => HelpScreen(),
      bindings: <Bindings>[
        HelpBindings()
      ],
      transition: Transition.downToUp,
    ),

    GetPage(
      name: RoutesName.profileScreen,
      page: () => ProfileScreen(),
      binding: ProfileBindings(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: RoutesName.paymentScreen,
      page: () => PaymentScreen(),
      binding: PaymentBindings(),
      transition: Transition.downToUp,
    ),

    GetPage(name: RoutesName.preferenceScreen,
      page: () => PreferenceScreen(),
      binding: PreferenceBindings(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: RoutesName.appearanceScreen,
      page: () => AppearanceScreen(),
      binding: AppearanceBindings(),
      transition: Transition.downToUp,
    ),    GetPage(
      name: RoutesName.surferScreen,
      page: () => SurferScreen(),
      binding: SurferBindings(),
      transition: Transition.downToUp,
    ),


  //   checkOut Screen

    GetPage(
      name: RoutesName.checkOutScreen,
      page: () => CheckOutScreen(carRent: 0.0,carType: "",),
      binding: CheckOutBindings(),
      transition: Transition.downToUp,
    ),

    GetPage(
      name: RoutesName.carDetailsScreen,
      page: () => CarDetailsScreen(isTextShow: false,),
      binding: CarDetailsBindings(),
      transition: Transition.downToUp,
    ),
  ];
}
