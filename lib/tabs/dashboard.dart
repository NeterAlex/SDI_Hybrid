import 'package:flutter/material.dart';

import '../widgets/recent_card.dart';
import '../widgets/upload_card.dart';

class DashboardTab extends StatefulWidget {
  const DashboardTab({super.key});

  @override
  State<DashboardTab> createState() => _DashboardTabState();
}

class _DashboardTabState extends State<DashboardTab> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          UploadCard(),
          RecentCard(),
        ]),
      ),
    );
  }
}
