import 'package:flutter/material.dart';
import 'package:mobileproject/core/models/transaction_model.dart';
import 'package:mobileproject/core/theming/styles.dart';
import 'package:mobileproject/core/widgets/app_text_btn.dart';

class TransactionsScreen extends StatefulWidget {
  final List<Transactions> transactions;

  // Constructor to accept the list of transactions
  TransactionsScreen({required this.transactions});

  @override
  _TransactionsScreenState createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    // Filter transactions based on the selected date
    final filteredTransactions = selectedDate == null
        ? []
        : widget.transactions.where((tx) {
            return tx.date.year == selectedDate!.year &&
                tx.date.month == selectedDate!.month &&
                tx.date.day == selectedDate!.day;
          }).toList();

    return Column(
      children: [
        // Date Picker Section
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: AppTextBtn(
            buttonWidth: double.maxFinite,
              buttonText: selectedDate == null
                  ? "Select a Date"
                  : "Selected: ${selectedDate!.toLocal()}".split(' ')[1],
              textStyle: MyTextStyle.font18WhiteRegular,
              onPressed: () async {
                final pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime.now(),
                );
                if (pickedDate != null) {
                  setState(() {
                    selectedDate = pickedDate;
                  });
                }
              }),
        ),
        // Transactions List
        Expanded(
          child: filteredTransactions.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.hourglass_empty_rounded,size: 200,),
                      SizedBox(height: 16,),
                      Text(
                        "No transactions \nfor the selected day.",textAlign: TextAlign.center,
                        style: MyTextStyle.font26BlackBold,
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: filteredTransactions.length,
                  itemBuilder: (ctx, index) {
                    final userTrans = filteredTransactions[index];
                    return Card(
                      elevation: 2,
                      color: Colors.white,
                      margin: EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                      child: ListTile(
                        title: Text(userTrans.user),
                        subtitle:
                            Text("Amount: \$${userTrans.amount.toStringAsFixed(2)}"),
                        trailing: Text(
                          "${userTrans.date.toLocal()}".split(' ')[0],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
