import 'package:flutter/material.dart';
import 'package:sdi_hybrid/widgets/page/history_page.dart';

class HistoryTab extends StatefulWidget {
  const HistoryTab({super.key});

  @override
  State<HistoryTab> createState() => _HistoryTabState();
}

class _HistoryTabState extends State<HistoryTab> {
  @override
  Widget build(BuildContext context) {
    return const HistoryPage();
  }
}
