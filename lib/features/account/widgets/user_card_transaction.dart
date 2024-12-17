import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobileproject/core/models/transaction_model.dart';
import 'package:mobileproject/core/theming/styles.dart';
import 'package:mobileproject/core/widgets/app_text_btn.dart';

class TransactionsScreen extends ConsumerStatefulWidget {
  // Constructor to accept the list of transactions
  const TransactionsScreen({super.key});

  @override
  ConsumerState createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends ConsumerState<TransactionsScreen> {
  DateTime? selectedDate;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Transactions> allTransactions = [];

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
      allTransactions = allTransactions;
    });
  }
  Future<void> fetchUsersAndTransactions() async {
    // Reference to users collection
    CollectionReference usersCollection =
    FirebaseFirestore.instance.collection('users');

    try {
      // Fetch all users
      QuerySnapshot usersSnapshot = await usersCollection.get();

      for (var userDoc in usersSnapshot.docs) {
        String userName = userDoc['name'] ?? 'No Name';
        print("User: $userName");

        // Attempt to fetch transactions as a subcollection
        CollectionReference transactionsCollection =
        userDoc.reference.collection('transactions');
        QuerySnapshot transactionsSnapshot = await transactionsCollection.get();

        if (transactionsSnapshot.docs.isNotEmpty) {
          for (var transactionDoc in transactionsSnapshot.docs) {
            int amount = transactionDoc['amount'] ?? 0;
            String date = transactionDoc['date'] ?? 'No Date';
            print("  Transaction - Amount: $amount, Date: $date");

            // Fetch orderedItems list
            List orderedItems = transactionDoc['orderedItems'] ?? [];
            for (var item in orderedItems) {
              int quantity = item['quantity'] ?? 0;
              double price = item['price']?.toDouble() ?? 0.0;
              print("    Item - Quantity: $quantity, Price: $price");
            }
          }
        } else {
          print("  No transactions found for $userName.");
        }
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUsersAndTransactions();
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [

      ]
    );
  }
}
