import 'package:flutter/material.dart';
import 'package:mobileproject/core/theming/styles.dart';
import 'package:mobileproject/core/widgets/app_text_field.dart';

class MyDetailsScreen extends StatefulWidget {
  const MyDetailsScreen({super.key});

  @override
  State<MyDetailsScreen> createState() => _MyDetailsScreenState();
}

class _MyDetailsScreenState extends State<MyDetailsScreen> {
  final _emailController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  ///////////-retrieve user data and fill the txt field with it -///////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Details",
          style: MyTextStyle.font22BlackSemiBold,
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_none),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(
              thickness: 2,
            ),
            SizedBox(height: 20,),
            Text("Full Name",style: MyTextStyle.font18LightBlackRegular,),
            AppTextField(
              controller: _emailController,
              errorOccurance: false,
              hintText: "FullName",
              isSecuredField: false,
              usePrefixIcon: false,
              validator: (String) {},
              useSuffixIcon: false,
              
            ),
            SizedBox(height: 16,),
            Text("Email Address",style: MyTextStyle.font18LightBlackRegular,),
            AppTextField(
              controller: _emailController,
              errorOccurance: false,
              hintText: "Email",
              isSecuredField: false,
              usePrefixIcon: false,
              validator: (String) {},
              useSuffixIcon: false,

            ),SizedBox(height: 16,),
            Text("Phone Number",style: MyTextStyle.font18LightBlackRegular,),
            AppTextField(
              controller: _emailController,
              errorOccurance: false,
              hintText: "+2012XXXXXXX",
              isSecuredField: false,
              usePrefixIcon: false,
              validator: (String) {},
              useSuffixIcon: false,

            ),

          ],
        ),
      ),
    );
  }
}
