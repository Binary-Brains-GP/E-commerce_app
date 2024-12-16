import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileproject/core/helpers/providers/privileges_provider.dart';

class AccountScreen extends ConsumerStatefulWidget {
  const AccountScreen({super.key});

  @override
  ConsumerState<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends ConsumerState<AccountScreen> {
  @override
  Widget build(BuildContext context) {
  final currentUser = ref.watch(privilegesProvider).valueOrNull!;
  final isAdmin = currentUser.isAdmin;
    return Scaffold(
      appBar: null,
      body: Center(
        child: Text(isAdmin.toString()),
      ),
    );
  }
}
