import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SizeButton extends StatelessWidget {
  const SizeButton({
    super.key,
    required this.letter,
    required this.isSelected,
    required this.onSelect,
  });
  final String letter;
  final bool isSelected;
  final VoidCallback onSelect;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        backgroundColor:
            WidgetStatePropertyAll(isSelected ? Colors.black : null),
        shape: WidgetStatePropertyAll(
          ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        side: WidgetStatePropertyAll(
          BorderSide(
            width: 1.w,
            color: Colors.grey,
          ),
        ),
      ),
      onPressed: onSelect,
      child: Text(
        letter,
        style: TextStyle(
            color: isSelected ? Colors.white : Colors.black, fontSize: 30.sp),
      ),
    );
  }
}
