import 'package:flutter/material.dart';
import 'package:sdi_hybrid/components/image_uploader.dart';
import 'package:sdi_hybrid/components/recent_card.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String title = "首页";

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(children: [
            ImageUploader(),
            RecentCard(),
          ]),
        ),
      ),
    );
  }
}
