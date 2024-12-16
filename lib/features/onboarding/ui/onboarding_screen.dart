import 'package:flutter/material.dart';
import 'package:mobileproject/core/routing/routes.dart';
import 'package:mobileproject/core/theming/styles.dart';
import 'package:mobileproject/core/widgets/app_text_btn.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.only(top: 50),
        top: true,
        child: Stack(
          children: [
            Container(
                width: double.infinity,
                child: Image.asset(
                  "assets/images/waves.png",
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.topLeft,
                )),
            const Padding(
              padding: EdgeInsets.only(left: 14.0),
              child: Text(
                "Define\nyourself in\nyour\nunique\nway",
                style: TextStyle(
                    fontSize: 52,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Poppins",
                    height: 1),
              ),
            ),
            Container(
              alignment: Alignment.bottomRight,
              height: double.infinity,
              child: Image.asset(
                "assets/images/onboardingguy.png",
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        height: 100,
        child: Center(
          child: AppTextBtn(
            buttonText: "Get Started",
            textStyle: MyTextStyle.font18WhiteSemiBold,
            onPressed: () {Navigator.pushNamed(context, Routes.loginScreen);},
            buttonWidth: 341,
            buttonHeight: 60,
          ),
        ),
      ),
    );
  }
}
