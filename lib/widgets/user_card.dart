import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/user_provider.dart';

class UserCard extends StatefulWidget {
  const UserCard({super.key});

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  late UserProvider _userProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _userProvider = Provider.of<UserProvider>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
          child: Row(
            children: [
              Expanded(
                child: BrnShadowCard(
                    circular: 8,
                    padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.account_circle_outlined,
                              size: 30,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              _userProvider.user.nickname,
                              style: const TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        const Badge(
                          largeSize: 30,
                          smallSize: 30,
                          textStyle: TextStyle(fontSize: 15),
                          backgroundColor: Color.fromARGB(255, 41, 52, 71),
                          label: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text("用户"),
                          ),
                        )
                      ],
                    )),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
          child: Center(
              child: Column(
            children: [
              ElevatedButton(
                style: ButtonStyle(
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    )),
                    foregroundColor: WidgetStateProperty.resolveWith(
                        (states) => Colors.white),
                    fixedSize: WidgetStateProperty.resolveWith(
                        (states) => const Size(double.infinity, 60)),
                    backgroundColor: WidgetStateProperty.resolveWith(
                        (state) => const Color.fromARGB(176, 246, 50, 50))),
                onPressed: () {
                  _userProvider.logout();
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.logout_outlined),
                      Text("退出登录", style: TextStyle(fontSize: 15))
                    ],
                  ),
                ),
              ),
            ],
          )),
        ),
      ],
    );
  }
}
