import 'package:flutter/material.dart';
import 'package:mobileproject/core/routing/routes.dart';
import 'package:mobileproject/core/theming/colors.dart';
import 'package:mobileproject/core/theming/styles.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(child: Text("Account")),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: Icon(Icons.notifications_none),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(children: [
          const Divider(color: Colors.black12,),
          ListTile(
            leading: const Icon(Icons.shopping_bag_outlined, color: MyColors.myBlack),
            title:  Text('My Orders',style: MyTextStyle.font18LightBlackRegular,),
            trailing: const Icon(Icons.arrow_back_ios_new_outlined,textDirection: TextDirection.rtl,color: MyColors.myBlack,),
            onTap: () {Navigator.pushNamed(context, Routes.myOrdersScreen);},
          ),
          const Divider(color: Colors.black12,),

          ListTile(
            leading: const Icon(Icons.manage_accounts_outlined, color: MyColors.myBlack),
            title:  Text('My Details',style: MyTextStyle.font18LightBlackRegular,),
            trailing: const Icon(Icons.arrow_back_ios_new_outlined,textDirection: TextDirection.rtl,color: MyColors.myBlack,),
            onTap: () {Navigator.pushNamed(context, Routes.myDetailsScreen);},
          ),
          const Divider(color: Colors.black12,),
          ListTile(
            leading: const Icon(Icons.home_outlined, color: MyColors.myBlack),
            title:  Text('Address Book',style: MyTextStyle.font18LightBlackRegular,),
            trailing: const Icon(Icons.arrow_back_ios_new_outlined,textDirection: TextDirection.rtl,color: MyColors.myBlack,),
            onTap: () {},
          ),
          const Divider(color: Colors.black12,),
          ListTile(
            leading: const Icon(Icons.credit_card, color: MyColors.myBlack),
            title:  Text('Payment Methods',style: MyTextStyle.font18LightBlackRegular,),
            trailing: const Icon(Icons.arrow_back_ios_new_outlined,textDirection: TextDirection.rtl,color: MyColors.myBlack,),
            onTap: () {},
          ),
          const Divider(color: Colors.black12,),
          ListTile(
            leading: const Icon(Icons.notifications_none, color: MyColors.myBlack),
            title:  Text('Notifications',style: MyTextStyle.font18LightBlackRegular,),
            trailing: const Icon(Icons.arrow_back_ios_new_outlined,textDirection: TextDirection.rtl,color: MyColors.myBlack,),
            onTap: () {Navigator.pushNamed(context, Routes.notificationScreen);},
          ),
          const Divider(color: Colors.black12,),
          ListTile(
            leading: const Icon(Icons.question_mark_outlined, color: MyColors.myBlack),
            title:  Text('FAQs',style: MyTextStyle.font18LightBlackRegular,),
            trailing: const Icon(Icons.arrow_back_ios_new_outlined,textDirection: TextDirection.rtl,color: MyColors.myBlack,),
            onTap: () {Navigator.pushNamed(context, Routes.myFAQsScreen);},
          ),
          const Divider(color: Colors.black12,),
          ListTile(
            leading: const Icon(Icons.headphones, color: MyColors.myBlack),
            title:  Text('Help Center',style: MyTextStyle.font18LightBlackRegular,),
            trailing: const Icon(Icons.arrow_back_ios_new_outlined,textDirection: TextDirection.rtl,color: MyColors.myBlack,),
            onTap: () {Navigator.pushNamed(context, Routes.helpCenterScreen);},
          ),
          const Divider(color: Colors.black12,),


          ListTile(
            leading:  Icon(Icons.logout, color: Colors.red,textDirection: TextDirection.ltr,),
            title: const Text('Logout',style: TextStyle(fontSize: 18,color: Colors.red,fontFamily: "Poppins"),),
            onTap: () {
              // Logout action
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Logout'),
                  content: const Text('Are you sure you want to log out?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(ctx).pop(),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Logout'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],),
      ),
    );
  }
}
