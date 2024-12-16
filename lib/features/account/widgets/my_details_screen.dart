import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      // Get the current user
      final User? user = _auth.currentUser;
      if (user != null) {
        // Retrieve user details from Firestore
        DocumentSnapshot userDoc = await _firestore
            .collection('users') // Change 'users' to your Firestore collection name
            .doc(user.uid)
            .get();

        if (userDoc.exists) {
          Map<String, dynamic> userData =
          userDoc.data() as Map<String, dynamic>;

          // Populate controllers with user data
          setState(() {
            _emailController.text = userData['email'] ?? '';
            _fullNameController.text = userData['name'] ?? '';
            _phoneNumberController.text = userData['phoneNumber'] ?? '';
          });
        }
      }
    } catch (e) {
      // Handle errors
      print('Error loading user data: $e');
    }
  }

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
            SizedBox(height: 20),
            Text(
              "Full Name",
              style: MyTextStyle.font18LightBlackRegular,
            ),
            AppTextField(
              controller: _fullNameController,
              errorOccurance: false,
              hintText: "Full Name",
              isSecuredField: false,
              usePrefixIcon: false,
              validator: (String) {},
              useSuffixIcon: false,
            ),
            SizedBox(height: 16),
            Text(
              "Email Address",
              style: MyTextStyle.font18LightBlackRegular,
            ),
            AppTextField(
              controller: _emailController,
              errorOccurance: false,
              hintText: "Email",
              isSecuredField: false,
              usePrefixIcon: false,
              validator: (String) {},
              useSuffixIcon: false,
            ),
            SizedBox(height: 16),
            Text(
              "Phone Number",
              style: MyTextStyle.font18LightBlackRegular,
            ),
            AppTextField(
              controller: _phoneNumberController,
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
