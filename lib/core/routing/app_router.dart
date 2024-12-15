
import 'package:flutter/material.dart';
import 'package:mobileproject/core/routing/routes.dart';
import 'package:mobileproject/features/account/widgets/faqs_screen.dart';
import 'package:mobileproject/features/account/widgets/help_center_screen.dart';
import 'package:mobileproject/features/account/widgets/my_details_screen.dart';
import 'package:mobileproject/features/account/widgets/my_orders_screen.dart';
import 'package:mobileproject/features/account/widgets/notification_screen.dart';

import '../../features/forgot_password/ui/forgot_password_screen.dart';
import '../../features/login/ui/login_screen.dart';
import '../../features/sign_up/ui/sign_up_screen.dart';
import '../../features/splash/ui/splash_screen.dart';

class AppRouter {
  // final bool showHome;
  //
  // const AppRouter({
  //   required this.showHome,
  // });

  Route? generateRoute(RouteSettings settings) {
    //this arguments to be passed in any screen like this ( arguments as ClassName )
    //final arguments = settings.arguments;

    switch (settings.name) {
      case Routes.splashScreen:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
      case Routes.onBoardingScreen:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );
      case Routes.loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case Routes.signUpScreen:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case Routes.forgotPasswordScreen:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
      case Routes.helpCenterScreen:
        return MaterialPageRoute(builder: (_) => const HelpCenterScreen());
      case Routes.myFAQsScreen:
        return MaterialPageRoute(builder: (_) => const FaqsScreen());
      case Routes.notificationScreen:
        return MaterialPageRoute(builder: (_) =>  NotificationScreen());
      case Routes.myDetailsScreen:
        return MaterialPageRoute(builder: (_) => const MyDetailsScreen());
      case Routes.myOrdersScreen:
        return MaterialPageRoute(builder: (_) => const MyOrdersScreen());
      default:
        return null;
    }
  }
}
