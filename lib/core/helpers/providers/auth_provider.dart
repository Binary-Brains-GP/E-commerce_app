import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthProvider extends StateNotifier<String> {
  AuthProvider() : super('');
  Future<void> signIn(
      TextEditingController email, TextEditingController password) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email.text,
      password: password.text,
    );
    final currentUser = FirebaseAuth.instance.currentUser!;
    state = currentUser.uid;
  }

  Future<void> signUp(
      TextEditingController email, TextEditingController password) async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email.text,
      password: password.text,
    );
    final newUser = FirebaseAuth.instance.currentUser;
    state = newUser!.uid;
  }
}

final authProvider = StateNotifierProvider<AuthProvider, String>(
  (ref) {
    return AuthProvider();
  },
);
