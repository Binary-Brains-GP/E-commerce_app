import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobileproject/core/routing/routes.dart';
import 'package:mobileproject/core/theming/colors.dart';
import 'package:mobileproject/core/theming/styles.dart';
import 'package:mobileproject/core/widgets/app_text_btn.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({super.key});

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.popAndPushNamed(
                context, Routes.forgotPasswordScreen); // Navigate back
          },
        ),
        backgroundColor: Colors.white,
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            child: Padding(
              padding: EdgeInsets.only(left: 25.w, right: 25.w, bottom: 25.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Enter 4 Digit Code",
                      style: MyTextStyle.font32BlackBold),
                  SizedBox(height: 10.h),
                  Text(
                    """Enter 4 digit code that your receive on your email""",
                    style: MyTextStyle.font16DescriptionTextRegular,
                  ),
                  SizedBox(height: 20.h),
                  Padding(
                    padding: EdgeInsets.only(left: 25.w, right: 25.w),
                    child: PinCodeTextField(
                      appContext: context,
                      animationCurve: Easing.emphasizedAccelerate,
                      animationType: AnimationType.fade,
                      length: 4,
                      enableActiveFill: true,
                      cursorHeight: 25,
                      cursorColor: MyColors.myBlack,
                      textStyle: MyTextStyle.font32BlackBold,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      keyboardType: const TextInputType.numberWithOptions(),
                      pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          inactiveColor: MyColors.myLightGray,
                          selectedColor: MyColors.myGray,
                          activeFillColor: Colors.grey.shade100,
                          selectedFillColor: Colors.grey.shade100,
                          inactiveFillColor: Colors.grey.shade100,
                          activeColor: MyColors.myBlack,
                          fieldWidth: 64.w,
                          fieldHeight: 60.h,
                          borderWidth: 1.w,
                          borderRadius: BorderRadius.circular(10)),
                      onCompleted: (value) => {},
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Padding(
                    padding: EdgeInsets.only(left: 25.w, right: 25.w),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Email not received? ",
                            style: MyTextStyle.font16DescriptionTextRegular,
                          ),
                          InkWell(
                            onTap: () {
                              // Reset password logic
                            },
                            child: Text(
                              "Resend the code",
                              style: TextStyle(
                                  color: MyColors.myBlack,
                                  fontSize: 16.sp,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ]),
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
                              context, Routes.newPasswordScreen);
                        }),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
