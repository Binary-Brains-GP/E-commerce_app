import 'package:flutter/material.dart';
import 'package:mobileproject/core/theming/styles.dart';
import 'package:mobileproject/core/widgets/app_text_btn.dart';
import 'package:mobileproject/core/routing/routes.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(  // Centers the entire Column
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppTextBtn(
                buttonText: "To login",
                textStyle: MyTextStyle.font18WhiteSemiBold,
                onPressed: () {
                  Navigator.pushReplacementNamed(context, Routes.loginScreen);
                },
              ),
              const SizedBox(height: 20),
              AppTextBtn(
                buttonText: "To Sign UP",
                textStyle: MyTextStyle.font18WhiteSemiBold,
                onPressed: () {
                  Navigator.pushReplacementNamed(context, Routes.signUpScreen);
                },
              ),
              const SizedBox(height: 20),
              AppTextBtn(
                buttonText: "To Home",
                textStyle: MyTextStyle.font18WhiteSemiBold,
                onPressed: () {
                  Navigator.pushReplacementNamed(context, Routes.homeScreen);
                },
              ),
              const SizedBox(height: 20),
              AppTextBtn(
                buttonText: "To Forget password",
                textStyle: MyTextStyle.font18WhiteSemiBold,
                onPressed: () {
                  Navigator.pushNamed(context, Routes.forgotPasswordScreen);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
