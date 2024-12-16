import 'package:flutter/material.dart';
import 'package:mobileproject/core/theming/colors.dart';
import 'package:mobileproject/core/theming/styles.dart';
import 'package:mobileproject/core/widgets/app_text_btn.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  // To track the selected button
  bool isOngoingSelected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "My Orders",
          style: MyTextStyle.font22BlackSemiBold,
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications_none)),
          SizedBox(
            width: 15,
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: MyColors.myVeryLightGray,
              ),
              height: 60,
              width: 341,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Ongoing Button
                  AppTextBtn(
                    backGroundColor: isOngoingSelected
                        ? Colors.white
                        : MyColors.myVeryLightGray,
                    verticalPadding: 1,
                    buttonHeight: 35,
                    buttonWidth: 160,
                    buttonText: "Ongoing",
                    textStyle: TextStyle(
                      fontSize: 14,
                      color: isOngoingSelected ? Colors.black87 : Colors.black45,
                    ),
                    onPressed: () {
                      setState(() {
                        isOngoingSelected = true;
                      });
                    },
                  ),
                  // Complete Button
                  AppTextBtn(
                    backGroundColor: isOngoingSelected
                        ? MyColors.myVeryLightGray
                        : Colors.white,
                    verticalPadding: 1,
                    buttonHeight: 35,
                    buttonWidth: 160,
                    buttonText: "Complete",
                    textStyle: TextStyle(
                      fontSize: 14,
                      color: isOngoingSelected ? Colors.black45 : Colors.black87,
                    ),
                    onPressed: () {
                      setState(() {
                        isOngoingSelected = false;
                      });
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
