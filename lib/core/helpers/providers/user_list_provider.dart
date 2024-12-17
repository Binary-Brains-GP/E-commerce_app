import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileproject/core/models/user.dart';

class UserListProvider extends StateNotifier<List<User>> {
  UserListProvider() : super([]);
  Future<void> getUsersList() async {
    try {
      final QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('users').get();
      final List<User> userList = snapshot.docs
          .map(
            (e) => User.fromMap(e.id, e.data() as Map<String, dynamic>),
          )
          .toList();

      state = userList;
    } catch (e) {
      print('Error: $e');
    }
  }
}

final userListProvider = StateNotifierProvider<UserListProvider, List<User>>(
  (ref) => UserListProvider(),
);
