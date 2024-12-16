import "package:flutter/material.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'colors.dart';

class MyTextStyle {
  //her we add out custom fonts even if we gonna use it once (:
  static TextStyle font18WhiteSemiBold = TextStyle(
      fontSize: 18.sp,
      fontFamily: "poppins",
      fontWeight: FontWeight.w600,
      color: Colors.white);
  static TextStyle font18BlackSemiBold = TextStyle(
      fontSize: 18.sp,
      fontFamily: "poppins",
      fontWeight: FontWeight.w500,
      color: Colors.black);
  static TextStyle font22BlackSemiBold = TextStyle(
    fontSize: 22.sp,
    fontFamily: "poppins",
    fontWeight: FontWeight.w600,
    color: MyColors.myBlack,
  );
  static TextStyle font16LightGrayRegular = TextStyle(
      fontSize: 16.sp, fontFamily: "poppins", color: MyColors.myLightGray);
  static TextStyle font32BlackBold = TextStyle(
      fontSize: 32.sp,
      fontFamily: "poppins",
      fontWeight: FontWeight.bold,
      color: Colors.black);
  static TextStyle font24BlackBold = TextStyle(
      fontSize: 32.sp,
      fontFamily: "poppins",
      fontWeight: FontWeight.bold,
      color: Colors.black);
  static TextStyle font16GrayRegular = TextStyle(
    fontSize: 16.sp,
    fontFamily: "poppins",
    color: MyColors.myGray,
  );
  static TextStyle font18LightBlackRegular = TextStyle(
    fontSize: 18.sp,
    fontFamily: "poppins",
    color: MyColors.myLightBlack,
  );
  static TextStyle font26BlackBold = TextStyle(
      fontSize: 26.sp,
      fontFamily: "poppins",
      fontWeight: FontWeight.bold,
      color: Colors.black);

  static TextStyle font16DescriptionTextRegular = TextStyle(
    fontSize: 16.sp,
    fontFamily: "poppins",
    color: const Color.fromARGB(255, 128, 128, 128),
  );
  static TextStyle font16WhiteRegular = TextStyle(
    fontSize: 16.sp,
    fontFamily: "poppins",
    color: Colors.white,
  );
  static TextStyle font14WhiteRegular = TextStyle(
    fontSize: 14.sp,
    fontFamily: "poppins",
    color: Colors.white,
  );
}
