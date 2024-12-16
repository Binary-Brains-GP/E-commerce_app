import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthProvider extends StateNotifier<String> {
  AuthProvider() : super('');
  Future<void> signIn(
      TextEditingController email, TextEditingController password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      final currentUser = FirebaseAuth.instance.currentUser!;
      state = currentUser.uid;
    } catch (e) {
      print(e);
    }
  }

  Future<void> signUp(TextEditingController email,
      TextEditingController password, TextEditingController userName) async {
    final userCredentials =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email.text,
      password: password.text,
    );
    final newUser = userCredentials.user;
    if (newUser != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(newUser.uid)
          .set({
        'uid': newUser.uid,
        'name': userName,
        'email': email,
        'isAdmin': false,
      });
    }
    state = newUser!.uid;
  }
}

final authProvider = StateNotifierProvider<AuthProvider, String>(
  (ref) {
    return AuthProvider();
  },
);
