import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';

class UserCard extends StatefulWidget {
  const UserCard({super.key});

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  bool enabled = false;
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return BrnEnhanceNumberCard(
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
    );
  }
}
