
import 'package:flutter/material.dart';
import 'package:mobileproject/core/routing/routes.dart';
import 'package:mobileproject/features/account/ui/account_screen.dart';
import 'package:mobileproject/features/account/widgets/faqs_screen.dart';
import 'package:mobileproject/features/account/widgets/help_center_screen.dart';
import 'package:mobileproject/features/account/widgets/my_details_screen.dart';
import 'package:mobileproject/features/account/widgets/my_orders_screen.dart';
import 'package:mobileproject/features/account/widgets/notification_screen.dart';
import 'package:mobileproject/features/onboarding/ui/onboarding_screen.dart';

import '../../features/forgot_password/ui/forgot_password_screen.dart';
import '../../features/forgot_password/ui/new_password_screen.dart';
import '../../features/forgot_password/ui/verify_screen.dart';
import '../../features/login/ui/login_screen.dart';
import '../../features/sign_up/ui/sign_up_Screen.dart';
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
          builder: (_) => SplashScreen(),
        );
      case Routes.onBoardingScreen:
        return MaterialPageRoute(
          builder: (_) => OnboardingScreen(),
        );
      case Routes.loginScreen:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case Routes.signUpScreen:
        return MaterialPageRoute(builder: (_) => SignUpScreen());
      case Routes.forgotPasswordScreen:
        return MaterialPageRoute(builder: (_) => ForgotPasswordScreen());
      case Routes.newPasswordScreen:
        return MaterialPageRoute(builder: (_) => NewPasswordScreen());
      case Routes.verifyScreen:
        return MaterialPageRoute(builder: (_) => VerifyScreen());
      case Routes.accountScreen:
        return MaterialPageRoute(builder: (_) => AccountScreen());
      case Routes.myDetailsScreen:
        return MaterialPageRoute(builder: (_) => MyDetailsScreen());
      case Routes.notificationScreen:
        return MaterialPageRoute(builder: (_) => NotificationScreen());
      case Routes.myFAQsScreen:
        return MaterialPageRoute(builder: (_) => FaqsScreen());
      case Routes.helpCenterScreen:
        return MaterialPageRoute(builder: (_) => HelpCenterScreen());
      case Routes.myOrdersScreen:
        return MaterialPageRoute(builder: (_) => MyOrdersScreen());
      default:
        return null;
    }
  }
}
