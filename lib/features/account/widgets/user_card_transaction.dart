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

  Future<void> fetchAllTransactions() async {
    QuerySnapshot usersSnapshot = await _firestore.collection('users').get();
    List tempTransactions = [];

    for (var userDoc in usersSnapshot.docs) {
      if (userDoc.data() is Map<String, dynamic> &&
          (userDoc.data() as Map<String, dynamic>)
              .containsKey('transactions')) {
        final userTransactions = userDoc['transactions'];
        if (userTransactions is List) {
          tempTransactions.addAll(userTransactions);
        }
      }
    }

    setState(() {
      allTransactions = tempTransactions.cast<Transactions>();
  });
    print(allTransactions[0].date);
  }

  @override
  void initState() {
    super.initState();
    fetchAllTransactions();
  }

  @override
  Widget build(BuildContext context) {

    // Filter transactions based on the selected date
    final List filteredTransactions = selectedDate == null
        ? []
        : allTransactions.where((tx) {
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
                      const Icon(
                        Icons.hourglass_empty_rounded,
                        size: 200,
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      Text(
                        "No transactions \nfor the selected day.",
                        textAlign: TextAlign.center,
                        style: MyTextStyle.font26BlackBold,
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: filteredTransactions.length,
                  itemBuilder: (ctx, indx) {
                    final userTrans = filteredTransactions[indx];
                    return Card(
                      elevation: 2,
                      color: Colors.white,
                      margin: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                      child: ListTile(
                        title: Text(userTrans.user),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Total Amount: \$${userTrans.amount.toStringAsFixed(2)}",
                            ),
                            const Text(
                              "Products ordered: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),

                            Wrap(
                              children: userTrans.orderedItems
                                  .map((item) => Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(item.name),
                                            Row(
                                              children: [
                                                const Text(
                                                  "Quantity:",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(item.cartQuantity
                                                    .toString()),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ))
                                  .toList(),
                            ),
                            // SizedBox(
                            //   height: 100,
                            //   child: ListView.builder(
                            //     itemCount: filteredTransactions[indx]
                            //         .orderedItems
                            //         .length,
                            //     itemBuilder: (context, index) {
                            //       return Text(filteredTransactions[indx]
                            //           .orderedItems[index]
                            //           .name);
                            //     },
                            //   ),
                            // )
                          ],
                        ),
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
