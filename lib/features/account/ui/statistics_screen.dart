import 'package:flutter/material.dart';
import 'package:mobileproject/core/theming/styles.dart';
import 'package:mobileproject/features/home/ui/sub_screen/Admin/best_selling_screen.dart';
class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Best Selling Items",style: MyTextStyle.font26BlackBold,),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: BestSelling(),
    );
  }
}
