import 'package:flutter/material.dart';

class AccountFormPage extends StatelessWidget {
  final Map<String, dynamic> user;
  const AccountFormPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(user['name'])),
    );
  }
}
