import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobileproject/core/routing/routes.dart';
import 'package:mobileproject/core/theming/colors.dart';
import 'package:mobileproject/core/theming/styles.dart';
import 'package:mobileproject/core/widgets/app_text_btn.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  bool passwordVisible = true;
  bool confirmPasswordVisible = true;

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
                  Text("Reset Password", style: MyTextStyle.font32BlackBold),
                  Text(
                    """Set the new password for your account so you can login and access all the features.""",
                    style: MyTextStyle.font16DescriptionTextRegular,
                  ),
                  SizedBox(height: 20.h),
                  TextField(
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                    cursorColor: MyColors.myBlack,
                    obscureText: passwordVisible,
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
                      labelText: "New password",
                      filled: true,
                      fillColor: const Color.fromARGB(255, 255, 255, 255),
                      suffixIcon: IconButton(
                        icon: Icon(passwordVisible
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined),
                        onPressed: () {
                          setState(
                            () {
                              passwordVisible = !passwordVisible;
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  TextField(
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                    cursorColor: MyColors.myBlack,
                    obscureText: confirmPasswordVisible,
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
                      labelText: "Confirm password",
                      filled: true,
                      fillColor: const Color.fromARGB(255, 255, 255, 255),
                      suffixIcon: IconButton(
                        icon: Icon(confirmPasswordVisible
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined),
                          onPressed: () {
                            setState(
                                  () {
                                confirmPasswordVisible = !confirmPasswordVisible;
                              },
                            );
                        },
                      ),
                    ),
                  ),
                  const Spacer(flex: 1),
                  Center(
                    child: AppTextBtn(
                        backGroundColor: MyColors.myBlack,
                        buttonWidth: 341.w,
                        buttonHeight: 54.h,
                        buttonText: "Continue",
                        textStyle: MyTextStyle.font16WhiteRegular,
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.loginScreen);
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
