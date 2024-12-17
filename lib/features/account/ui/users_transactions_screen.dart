import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileproject/core/helpers/providers/transaction_provider.dart';
import 'package:mobileproject/core/models/transaction_model.dart';
import 'package:mobileproject/core/theming/styles.dart';
import 'package:mobileproject/features/account/widgets/user_card_transaction.dart';

class UsersReport extends ConsumerStatefulWidget {
  const UsersReport({super.key});

  @override
  ConsumerState<UsersReport> createState() => _UsersReportState();
}

class _UsersReportState extends ConsumerState<UsersReport> {
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
      body: const TransactionsScreen(),
    );
  }
}
