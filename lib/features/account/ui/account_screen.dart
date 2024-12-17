import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobileproject/core/routing/routes.dart';
import 'package:mobileproject/core/theming/colors.dart';
import 'package:mobileproject/core/theming/styles.dart';
import 'package:mobileproject/core/widgets/app_text_btn.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  Future<void> _logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut(); // Sign out the user
      Navigator.pushReplacementNamed(context, Routes.loginScreen);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  // Fetch isAdmin status for the current user
  Future<bool> _checkIfAdmin() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Assume isAdmin is stored in Firestore under 'users' collection
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      return doc.data()?['isAdmin'] ?? false;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Center(
            child: Text(
              "Account",
              style: MyTextStyle.font24BlackBold,
            )),
      ),
      body: FutureBuilder<bool>(
        future: _checkIfAdmin(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final bool isAdmin = snapshot.data ?? false;

          return Container(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Divider(color: Colors.black12),
                  ListTile(
                    leading: const Icon(Icons.shopping_bag_outlined,
                        color: MyColors.myBlack),
                    title: Text(
                      'My Orders',
                      style: MyTextStyle.font18LightBlackRegular,
                    ),
                    trailing: const Icon(
                      Icons.arrow_back_ios_new_outlined,
                      textDirection: TextDirection.rtl,
                      color: MyColors.myBlack,
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, Routes.myOrdersScreen);
                    },
                  ),
                  const Divider(color: Colors.black12),
                  ListTile(
                    leading: const Icon(Icons.manage_accounts_outlined,
                        color: MyColors.myBlack),
                    title: Text(
                      'My Details',
                      style: MyTextStyle.font18LightBlackRegular,
                    ),
                    trailing: const Icon(
                      Icons.arrow_back_ios_new_outlined,
                      textDirection: TextDirection.rtl,
                      color: MyColors.myBlack,
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, Routes.myDetailsScreen);
                    },
                  ),
                  if (isAdmin) ...[
                    const Divider(color: Colors.black12),
                    ListTile(
                      leading: const Icon(Icons.insert_chart_outlined,
                          color: MyColors.myBlack),
                      title: Text(
                        'Statistics',
                        style: MyTextStyle.font18LightBlackRegular,
                      ),
                      trailing: const Icon(
                        Icons.arrow_back_ios_new_outlined,
                        textDirection: TextDirection.rtl,
                        color: MyColors.myBlack,
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, Routes.statistics);
                      },
                    ),
                    const Divider(color: Colors.black12),
                    ListTile(
                      leading: const Icon(Icons.feedback_outlined,
                          color: MyColors.myBlack),
                      title: Text(
                        'Users Feedback',
                        style: MyTextStyle.font18LightBlackRegular,
                      ),
                      trailing: const Icon(
                        Icons.arrow_back_ios_new_outlined,
                        textDirection: TextDirection.rtl,
                        color: MyColors.myBlack,
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, Routes.usersFeedBack);
                      },
                    ),
                    const Divider(color: Colors.black12),
                    ListTile(
                      leading: const Icon(Icons.attach_money_outlined,
                          color: MyColors.myBlack),
                      title: Text(
                        'Users Transactions',
                        style: MyTextStyle.font18LightBlackRegular,
                      ),
                      trailing: const Icon(
                        Icons.arrow_back_ios_new_outlined,
                        textDirection: TextDirection.rtl,
                        color: MyColors.myBlack,
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, Routes.usersTransactions);
                      },
                    ),
                  ],
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
                  const Divider(color: Colors.black12),
                  ListTile(
                    leading: Icon(Icons.logout, color: Colors.red),
                    title: const Text(
                      'Logout',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.red,
                          fontFamily: "Poppins"),
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            title: const Column(
                              children: [
                                Icon(Icons.error_outline,
                                    color: Colors.red, size: 50),
                                SizedBox(height: 8),
                                Text(
                                  'Logout?',
                                  style:
                                  TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            content: const Text(
                              'Are you sure you want to logout?',
                              style: TextStyle(
                                  color: Colors.black38, fontSize: 16),
                            ),
                            actions: [
                              AppTextBtn(
                                backGroundColor: MyColors.myRed,
                                buttonText: "Yes, Logout",
                                textStyle:
                                MyTextStyle.font18WhiteRegular,
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  _logout(context);
                                },
                              ),
                              SizedBox(height: 12),
                              AppTextBtn(
                                borderColor: Colors.black12,
                                buttonText: "No, Cancel",
                                textStyle: MyTextStyle
                                    .font18LightBlackRegular,
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                backGroundColor: Colors.white,
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
