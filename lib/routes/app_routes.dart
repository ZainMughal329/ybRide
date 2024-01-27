import 'package:get/get.dart';
import 'package:yb_ride/routes/routes_name.dart';
import 'package:yb_ride/screens/application/inded.dart';
import 'package:yb_ride/screens/onBoarding/inded.dart';
import 'package:yb_ride/screens/pages/book_page/bindings.dart';
import 'package:yb_ride/screens/pages/book_page/inded.dart';
import 'package:yb_ride/screens/pages/invite_page/inded.dart';
import 'package:yb_ride/screens/session/login/inded.dart';
import 'package:yb_ride/screens/session/signUp/inded.dart';
import 'package:yb_ride/screens/session/welcome.dart';
import 'package:yb_ride/screens/settings/pages/profile/inded.dart';

class AppRoutes {
  static final List<GetPage> routes = [
    GetPage(
      name: RoutesName.onBoardingScreen,
      page: () => OnBoardingScreen(),
      binding: onBoardingBindings(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: RoutesName.welcomeScreen,
      page: () => WelcomePage(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: RoutesName.loginScreen,
      page: () => LoginScreen(),
      binding: LoginBindings(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: RoutesName.signUpScreen,
      page: () => SignupScreen(),
      binding: SignUpBindings(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: RoutesName.bookNowScreen,
      page: () => BookNowView(),
      binding: BookViewBindings(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: RoutesName.applicationScreen,
      page: () => ApplicationView(),
      bindings: <Bindings>[
        ApplicationViewBindings(),
        BookViewBindings(),
      ],
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: RoutesName.inviteScreen,
      page: () => InviteScreen(),
      bindings: <Bindings>[
        ApplicationViewBindings(),
        InviteBindings(),
        BookViewBindings(),
      ],
      transition: Transition.rightToLeft,
    ),

    GetPage(
      name: RoutesName.profileScreen,
      page: () => ProfileScreen(),
      binding: ProfileBindings(),
      transition: Transition.rightToLeft,
    ),
  ];
}
