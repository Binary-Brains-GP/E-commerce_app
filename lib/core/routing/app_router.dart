import 'package:flutter/material.dart';
import 'package:mobileproject/core/routing/routes.dart';
import 'package:mobileproject/features/account/widgets/faqs_screen.dart';
import 'package:mobileproject/features/account/widgets/help_center_screen.dart';
import 'package:mobileproject/features/account/widgets/my_details_screen.dart';
import 'package:mobileproject/features/account/widgets/my_orders_screen.dart';
import 'package:mobileproject/features/account/widgets/notification_screen.dart';
import 'package:mobileproject/features/home/ui/sub_screen/cloth_details_screen.dart';
import 'package:mobileproject/features/onboarding/ui/onboarding_screen.dart';
import 'package:mobileproject/features/checkout/checkout_screen.dart';

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

      case Routes.onBoardingScreen:
        return MaterialPageRoute(
          builder: (_) => const OnboardingScreen(),
        );
      case Routes.loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case Routes.signUpScreen:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case Routes.forgotPasswordScreen:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
      case Routes.newPasswordScreen:
        // return MaterialPageRoute(builder: (_) => const NewPasswordScreen());
      case Routes.verifyScreen:
        // return MaterialPageRoute(builder: (_) => const VerifyScreen());
      default:
        return null;
    }
  }
}
