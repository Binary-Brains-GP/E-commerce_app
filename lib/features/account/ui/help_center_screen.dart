import 'package:flutter/material.dart';
import 'package:mobileproject/core/theming/styles.dart';
import 'package:mobileproject/features/account/widgets/help_center_text_icon_btn.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Help Center",
          style: MyTextStyle.font22BlackSemiBold,
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications_none))
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Divider(
              thickness: 1,
            ),
            SizedBox(height: 20),
            HelpCenterTextIconBtn(
              onPressed: (){},
              IconUsed: Icons.headset_mic_outlined,
              itemText: "Customer Service",
            ),
            SizedBox(height: 20),
            HelpCenterTextIconBtn(
              onPressed: (){},
              IconUsed: Icons.message_outlined,
              itemText: "Whatsapp",
            ),
            SizedBox(height: 20),
            HelpCenterTextIconBtn(
              onPressed: (){},
              IconUsed: Icons.web_outlined,
              itemText: "Website",
            ),SizedBox(height: 20),
            HelpCenterTextIconBtn(
              onPressed: (){},
              IconUsed: Icons.facebook_outlined,
              itemText: "Facebook",
            ),SizedBox(height: 20),


          ],
        ),
      ),
    );
  }
}
