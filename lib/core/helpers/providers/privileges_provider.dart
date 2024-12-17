import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobileproject/core/models/user.dart';

class PrivilegesProvider extends AsyncNotifier<User?> {
  @override
  Future<User?> build() async {
    return null; // Default state is no user.
  }

  Future<void> fetchUserData(String uid) async {
    try {
      state = const AsyncLoading();

      // Fetch user data from Firestore
      final userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (userDoc.exists) {
        final userData = userDoc.data()!;
        final appUser = User.fromMap(uid, userData);

        state = AsyncData(appUser);
      } else {
        state = AsyncError("User not found", StackTrace as StackTrace);
      }
    } catch (e) {
      print("Error: $e");
    }
  }
}

final privilegesProvider = AsyncNotifierProvider<PrivilegesProvider, User?>(() {
  return PrivilegesProvider();
});
