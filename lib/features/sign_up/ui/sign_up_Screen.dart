import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobileproject/core/theming/colors.dart';
import 'package:mobileproject/core/theming/styles.dart';
import 'package:mobileproject/features/login/ui/login_screen.dart';
import 'package:mobileproject/features/sign_up/ui/widgets/sign_up_form.dart';
import 'package:mobileproject/features/sign_up/ui/widgets/socialmedia_options.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          left: 19,
          right: 19,
        ),
        child: Container(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Create an account",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 30.sp,
                    ),
                  ),
                  Text(
                    "Let's create your account",
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: MyColors.myGray,
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SignUpForm(),

                  SizedBox(
                    height: 25.h,
                  ),
                  const SocialmediaOptions(), //-----------social media icon buttons---------------
                  SizedBox(
                    height: 20.sp,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account? ',
                        style: TextStyle(
                          color: MyColors.myGray,
                          fontSize: 16.sp,
                          fontFamily:
                              MyTextStyle.font18BlackSemiBold.fontFamily,
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()));
                          final prefs = await SharedPreferences.getInstance();
                          prefs.setBool('showHome', true);
                        },
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.black87,
                            fontSize: 16.sp,
                            fontFamily:
                                MyTextStyle.font18BlackSemiBold.fontFamily,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
