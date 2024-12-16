import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthProvider extends StateNotifier<String> {
  AuthProvider() : super('');
  Future<void> signIn(
      TextEditingController email, TextEditingController password) async {
    // final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
    //   email: email.text,
    //   password: password.text,
    // );
    try {
      final userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      print('User ID: ${userCredential.user?.uid}');
    } catch (e) {
      print('Error signing in: $e');
    }
  }

  Future<void> signUp(
      TextEditingController email, TextEditingController password) async {
    try{
    final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email.text,
      password: password.text,
    );
     print('User ID: ${userCredential.user?.uid}');
    } catch (e) {
      print('Error signing in: $e');
    }
    final newUser = FirebaseAuth.instance.currentUser;
    state = newUser!.uid;
  }
}

final authProvider = StateNotifierProvider<AuthProvider, String>(
  (ref) {
    return AuthProvider();
  },
);
