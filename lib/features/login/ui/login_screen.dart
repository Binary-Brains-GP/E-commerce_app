import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobileproject/core/theming/colors.dart';
import 'package:mobileproject/core/theming/styles.dart';
import 'package:mobileproject/features/login/ui/widgets/google_login.dart';
import 'package:mobileproject/features/login/ui/widgets/login_form.dart';
import 'package:mobileproject/features/sign_up/ui/sign_up_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                    "Login to your account",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 30.sp,
                    ),
                  ),
                  SizedBox(height: 5.w),
                  Text(
                    "It's great to see you again",
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
                  const LoginForm(), //--------------------Login form widget------------------
                  //---------------------------------------------------------------------------
                  SizedBox(
                    height: 25.h,
                  ),
                  const GoogleLogin(), //-------------google sign in part----------------
                  //----------------------------------------------------------------------
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account? ',
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
                                  builder: (context) => const SignUpScreen()));
                          final prefs = await SharedPreferences.getInstance();
                          prefs.setBool('showHome', true);
                        },
                        child: Text(
                          'Join us',
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
