import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mobileproject/core/theming/styles.dart';

class UsersFeedbackScreen extends StatefulWidget {
  const UsersFeedbackScreen({super.key});

  @override
  State<UsersFeedbackScreen> createState() => _UsersFeedbackScreenState();
}

class _UsersFeedbackScreenState extends State<UsersFeedbackScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List allCartItems = []; // To store all users' cart item

  Future<void> fetchAllCartItems() async {
    QuerySnapshot usersSnapshot =
        await _firestore.collection('users').get(); // Fetch all users
    List tempCartItems = [];

    for (var userDoc in usersSnapshot.docs) {
      // Safely check if 'cartItems' exists and is a list
      if (userDoc.data() is Map<String, dynamic> &&
          (userDoc.data() as Map<String, dynamic>).containsKey('cartItems')) {
        final userCartItems = userDoc['cartItems'];
        if (userCartItems is List) {
          tempCartItems.addAll(userCartItems);
        }
      }
    }

    setState(() {
      allCartItems = tempCartItems;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchAllCartItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Users Cart Items',style: MyTextStyle.font22BlackSemiBold,),
        centerTitle: true,
        backgroundColor: Colors.white,

      ),
      body: allCartItems.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: allCartItems.length,
              itemBuilder: (context, index) {
                final item = allCartItems[index];
                final int rating = item['rate'] ?? 0;

                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(
                      'Item: ${item['name']}',
                      style: MyTextStyle.font18LightBlackRegular,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Price: \$${item['price']}',
                          style: MyTextStyle.font18LightBlackRegular,
                        ),
                        Text(
                          'Feedback: ${item['feedback'] ?? 'No Feedback'}',
                          style: MyTextStyle.font18LightBlackRegular,
                        ),
                        const SizedBox(height: 5),
                        // Star Rating Display
                        RatingBarIndicator(
                          rating: rating.toDouble(),
                          itemCount: 5,
                          itemSize: 30.0,
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
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
