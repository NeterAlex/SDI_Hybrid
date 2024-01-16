import 'package:flutter/material.dart';
import 'package:sdi_hybrid/widgets/history_page.dart';

class HistoryTab extends StatefulWidget {
  const HistoryTab({super.key});

  @override
  State<HistoryTab> createState() => _HistoryTabState();
}

class _HistoryTabState extends State<HistoryTab> {
  String title = "识别记录";

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: HistoryPage(),
      ),
    );
  }
}
