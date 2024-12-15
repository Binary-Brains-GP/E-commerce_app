import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobileproject/core/theming/styles.dart';

class HelpCenterTextIconBtn extends StatelessWidget {
 final String itemText;
 final IconData IconUsed;
 final VoidCallback onPressed;

  HelpCenterTextIconBtn({required this.itemText, required this.IconUsed, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.only(bottom: 15, top: 15,left: 20),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),border: Border.all(color: Colors.black45)),
        child: Row(
          children: [
            Icon(IconUsed),
            SizedBox(width: 16,),
            Text(itemText,style: MyTextStyle.font18LightBlackRegular,)
          ],
        ),
      ),
    );
  }
}
