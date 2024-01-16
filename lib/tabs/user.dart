import 'package:flutter/material.dart';
import 'package:sdi_hybrid/components/login.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  String title = "用户";

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: LoginPage(),
      ),
    );
  }
}
