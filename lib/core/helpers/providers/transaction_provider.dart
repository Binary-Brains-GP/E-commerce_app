import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileproject/core/models/clothes.dart';
import 'package:mobileproject/core/models/transaction_model.dart';

class TransactionProvider extends StateNotifier<List<Transactions>> {
  TransactionProvider() : super([]);

  void addTransaction(String user, double total, List<Clothes> orderedItems) {
    final Transactions transaction = Transactions(
      user: user,
      amount: total,
      date: DateTime.now(),
      orderedItems: orderedItems,
    );

    state = [...state, transaction];
  }

   void addListToUser() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    try{
    final String? userID = _auth.currentUser?.uid;

    if(userID == null){
      throw Exception("No user signed in");
    }

    final List<Map<String,dynamic>> transactions = state.map((e) => e.toMap(),).toList();

    final userDoc = _firestore.collection('users').doc(userID);
    await userDoc.update({
      'transactions': transactions,
    });
    }catch(e){
      print("Error: $e --------------------");
    }
  }
}

final transactionProvider =
    StateNotifierProvider<TransactionProvider, List<Transactions>>(
  (ref) => TransactionProvider(),
);
