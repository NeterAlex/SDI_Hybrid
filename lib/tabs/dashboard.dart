import 'package:flutter/material.dart';

import '../widgets/recent_card.dart';
import '../widgets/upload_card.dart';

class DashboardTab extends StatefulWidget {
  const DashboardTab({super.key});

  @override
  State<DashboardTab> createState() => _DashboardTabState();
}

class _DashboardTabState extends State<DashboardTab> {
  String title = "首页";

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(children: [
            UploadCard(),
            RecentCard(),
          ]),
        ),
      ),
    );
  }
}
