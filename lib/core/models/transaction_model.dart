import 'package:mobileproject/core/models/clothes.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Transactions {
  final String id;
  final String user;
  final double amount;
  final DateTime date;
  final List<Clothes> orderedItems;

  Transactions({
    required this.user,
    required this.amount,
    required this.date,
    required this.orderedItems,
    String? id,
  }) : id = id ?? uuid.v4();

  Map<String, dynamic> toMap() {
    return {
      'name' : user,
      'amount': amount,
      'date': date,
      'orderedItems': orderedItems
          .map(
            (e) => e.toMap(),
          )
          .toList(),
    };
  }
}
