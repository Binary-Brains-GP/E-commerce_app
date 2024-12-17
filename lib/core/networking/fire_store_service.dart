import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobileproject/core/models/clothes.dart';
import 'package:mobileproject/core/models/transaction_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Transactions>> fetchAllTransactions() async {
    List<Transactions> allTransactions = [];

    try {
      // Fetch all user documents
      QuerySnapshot usersSnapshot = await _firestore.collection('users').get();

      for (var userDoc in usersSnapshot.docs) {
        // Safely check if 'transactions' exists and is a list
        if (userDoc.data() is Map<String, dynamic> &&
            (userDoc.data() as Map<String, dynamic>).containsKey('transactions')) {
          final userTransactions = userDoc['transactions'];
          if (userTransactions is List) {
            for (var transaction in userTransactions) {
              // Map Firestore transaction to Transactions object
              Transactions trans = Transactions(
                user: transaction['name'] ?? 'Unknown',
                amount: (transaction['amount'] ?? 0).toDouble(),
                // Format the date to yyyy-MM-dd before creating a DateTime
                date: DateTime.parse(
                  (transaction['date'] as Timestamp).toDate().toLocal().toString().split(' ')[0],
                ),
                orderedItems: (transaction['orderedItems'] as List)
                    .map((item) => Clothes(
                  name: item['name'] ?? 'Unknown',
                  price: (item['price'] ?? 0).toDouble(),
                  quantity: item['quantity'] ?? 1,
                  rate: item['rate'] != null ? item['rate'].toDouble() : null,
                  feedback: item['feedback'],
                ))
                    .toList(),
              );

              allTransactions.add(trans);
            }
          }
        }
      }
    } catch (e) {
      print("Error fetching transactions: $e");
    }

    return allTransactions;
  }
}
