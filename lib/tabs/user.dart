import 'package:flutter/material.dart';

import '../widgets/login_page.dart';

class UserTab extends StatefulWidget {
  const UserTab({super.key});

  @override
  State<UserTab> createState() => _UserTabState();
}

class _UserTabState extends State<UserTab> {
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
