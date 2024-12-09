import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType? keyboardType;
  final bool errorAccurance;
  final String? Function(String?)? validator;

  final bool
      usePrefixIcon; //------------if true, pass the icon to the prefixIcon var---------
  final IconData? prefixIcon;
//--------------------------------------Password properties--------------------------------------------------
  final bool
      isSecuredField; //--------is this field a secure field or not???-------------
  final IconData? suffixIconVisible;
  final IconData? suffixIconHidden;
  final bool? obscureText;
  final Function()? onSuffixIconPressed;
  //---------------------Constants-----------------------
  final Color prefixIconColor;
  final Color suffixIconColor;
  final BorderRadius borderRadius;
  final double blurRadius;
  final double spreadRadius;
  final double elevationOffset;
  final double contentPadding;
  final double blurOpacity;

  const AppTextField({
    super.key,
    required this.errorAccurance,
    required this.controller,
    required this.hintText,
    required this.isSecuredField,
    required this.usePrefixIcon,
    required this.validator,
    this.keyboardType,
    this.prefixIcon,
    this.obscureText,
    this.suffixIconVisible,
    this.suffixIconHidden,
    this.onSuffixIconPressed,
    this.prefixIconColor = Colors.grey,
    this.suffixIconColor = Colors.grey,
    this.borderRadius = const BorderRadius.all(Radius.circular(10)),
    this.blurRadius = 60,
    this.spreadRadius = 1,
    this.elevationOffset = 3,
    this.contentPadding = 15,
    this.blurOpacity = 0.6,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: borderRadius,
        border: Border.all(
          width: 1.w,
          color: errorAccurance
              ? Colors.red
              : const Color.fromARGB(255, 211, 211, 211),
        ),
      ),
      child: TextFormField(
        
        validator: validator,
        keyboardType: keyboardType,
        controller: controller,
        obscureText: isSecuredField ? obscureText! : false,
        decoration: InputDecoration(
          errorStyle: TextStyle(fontSize: 0.sp),
          prefixIcon:
              usePrefixIcon ? Icon(prefixIcon, color: prefixIconColor) : null,
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Color.fromARGB(255, 201, 200, 200),
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(contentPadding),
          suffixIcon: isSecuredField
              ? IconButton(
                  onPressed: onSuffixIconPressed,
                  icon: Icon(
                    obscureText! ? suffixIconHidden : suffixIconVisible,
                    color: suffixIconColor,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
