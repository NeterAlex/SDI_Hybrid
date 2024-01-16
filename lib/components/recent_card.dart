import 'dart:convert';

import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/config.dart';
import '../common/http.dart';
import '../state/user_provider.dart';

class RecentCard extends StatefulWidget {
  const RecentCard({super.key});

  @override
  State<RecentCard> createState() => _RecentCardState();
}

class _RecentCardState extends State<RecentCard> {
  bool enabled = false;
  bool isLoading = true;
  late UserProvider _userProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _userProvider = Provider.of<UserProvider>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          BrnShadowCard(
              child: Column(
            children: [
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
              ),
            ],
          )),
        ],
      ),
    );
  }
}

Future<void> requestList() async {
  // Build request
  final response = await dio.get("/data/list?user_id=1");
  var config = await ConfigHelper.getConfig();
  Map<String, dynamic> resp = json.decode(
    response.toString(),
  );
}
