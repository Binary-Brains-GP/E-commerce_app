import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileproject/core/models/transaction_model.dart';
import 'package:mobileproject/core/networking/fire_store_service.dart';
import 'package:mobileproject/core/theming/styles.dart';
import 'package:mobileproject/features/account/widgets/user_card_transaction.dart';

class UsersReport extends ConsumerStatefulWidget {
  const UsersReport({super.key});

  @override
  ConsumerState<UsersReport> createState() => _UsersReportState();
}

class _UsersReportState extends ConsumerState<UsersReport> {
  List<Transactions> transactions = [];

  void loadTransactions() async {
    FirestoreService service = FirestoreService();
    List<Transactions> fetchedTransactions = await service.fetchAllTransactions();

    // Set the fetched transactions to the state
    setState(() {
      transactions = fetchedTransactions;
    });

    // Print fetched transactions to verify
    for (var transaction in transactions) {
      for (var item in transaction.orderedItems) {
      }
    }
  }

  @override
  void initState() {
    super.initState();
    loadTransactions(); // Load transactions on init
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Users Transactions',
          style: MyTextStyle.font22BlackSemiBold,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: transactions.isEmpty
          ? Center(
        child: CircularProgressIndicator(), // Show loading indicator
      )
          : TransactionsScreen(transactions: transactions), // Pass the updated transactions
    );
  }
}
