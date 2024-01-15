import 'package:flutter/material.dart';
import 'package:sdi_hybrid/pages/history_gallery.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  String title = "识别记录";

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: HistoryGalleryPage(),
      ),
    );
  }
}
