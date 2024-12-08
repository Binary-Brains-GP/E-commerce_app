import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobileproject/core/routing/routes.dart';
import 'package:mobileproject/core/theming/colors.dart';
import 'package:mobileproject/core/theming/styles.dart';
import 'package:mobileproject/core/widgets/app_text_btn.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back
          },
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            child: Padding(
          padding: EdgeInsets.only(
              top: 0.h, right: 25.0.w, left: 25.0.w, bottom: 25.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Forgot password", style: MyTextStyle.font32BlackBold),
              Text(
                """Enter your email for the verification process.
We will send 4 digits code to your email.""",
                style: MyTextStyle.font16DescriptionTextRegular,
              ),
              SizedBox(height: 20.h),
              // Material(
              //   // elevation: 5, // Elevation for the shadow effect
              //   borderRadius: BorderRadius.circular(10), // Rounded corners
              //   // shadowColor:
              //       // const Color.fromARGB(43, 44, 67, 224), // Shadow color
              //   child:
              // ),
              TextField(
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: MyColors.myBlack,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      labelStyle: MyTextStyle.font16DescriptionTextRegular,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(width: 1, color: MyColors.myBlack),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(width: 1, color: MyColors.myBlack),
                      ),
                      focusColor: MyColors.myBlack,
                      hoverColor: MyColors.myBlack,
                      labelText: "Email",
                      filled: true,
                      fillColor: const Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
              const Spacer(flex: 1),
              Center(
                child: AppTextBtn(
                    backGroundColor: MyColors.myBlack,
                    buttonWidth: 341.w,
                    buttonHeight: 54.h,
                    buttonText: "Send Code",
                    textStyle: MyTextStyle.font16WhiteRegular,
                    onPressed: () {
                      Navigator.pushNamed(
                          context, Routes.verifyScreen);
                    }),
              )
            ],
          ),
        ),
          )
        ],
        
      ),
    );
  }
}
