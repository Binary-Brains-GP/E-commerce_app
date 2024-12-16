import 'package:flutter/material.dart';
import 'package:mobileproject/core/models/transaction_model.dart';
import 'package:mobileproject/core/theming/styles.dart';
import 'package:mobileproject/features/account/widgets/user_card_transaction.dart';

class UsersReport extends StatelessWidget {
  const UsersReport({super.key});

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
            icon: Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: TransactionsScreen(transactions: [
        Transactions(
          id: 't1',
          user: 'Alice',
          amount: 250.75,
          date: DateTime(2024, 12, 16),
        ),
        Transactions(
          id: 't2',
          user: 'Bob',
          amount: 120.50,
          date: DateTime(2024, 12, 15),
        ),
        Transactions(
          id: 't3',
          user: 'Charlie',
          amount: 450.00,
          date: DateTime(2024, 12, 16),
        ),
      ],),
    );
  }
}
