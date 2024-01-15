import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String title = "首页";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(children: [
          BrnEnhanceNumberCard(
            padding: const EdgeInsets.all(20),
            rowCount: 2,
            itemChildren: [
              BrnNumberInfoItemModel(
                title: '霜霉病',
                number: '24',
              ),
              BrnNumberInfoItemModel(
                title: '白粉病',
                number: '180',
              ),
            ],
          )
        ]),
      ),
    );
  }
}
