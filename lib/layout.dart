import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sdi_hybrid/state/user_provider.dart';
import 'package:sdi_hybrid/tabs/user.dart';

import 'tabs/dashboard.dart';
import 'tabs/history.dart';
import 'widgets/login_page.dart';

class LayoutPage extends StatefulWidget {
  const LayoutPage({super.key, required this.title});

  final String title;

  @override
  State<LayoutPage> createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage> {
  late PageController _pageController;
  int currentPage = 0;
  var children = <Widget>[
    const KeepAliveView(isKeepAlive: false, child: DashboardTab()),
    const KeepAliveView(isKeepAlive: false, child: HistoryTab()),
    const KeepAliveView(isKeepAlive: true, child: UserTab())
  ];
  var titles = ['首页', '识别记录', '用户'];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0, keepPage: true);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BrnAppBar(
          leading: const Icon(
            Icons.search,
            color: Color.fromARGB(255, 46, 49, 59),
          ),
          themeData: BrnAppBarConfig.dark(),
          elevation: 4,
          title: 'Mildew Identifier',
        ),
        body: Consumer<UserProvider>(
          builder: (context, userProvider, _) {
            if (userProvider.user.id > 0) {
              return Column(
                children: [
                  Expanded(
                    child: PageView(
                      onPageChanged: (pagePos) {
                        setState(() {
                          currentPage = pagePos;
                        });
                      },
                      scrollDirection: Axis.horizontal,
                      controller: _pageController,
                      children: children,
                    ),
                  ),
                  BrnBottomTabBar(
                    fixedColor: Colors.blue,
                    currentIndex: currentPage,
                    onTap: (value) {
                      setState(() {
                        currentPage = value;
                        _pageController.jumpToPage(currentPage);
                      });
                    },
                    badgeColor: Colors.red,
                    items: <BrnBottomTabBarItem>[
                      BrnBottomTabBarItem(
                          icon: const Icon(Icons.home_outlined),
                          title: Text(titles[0])),
                      BrnBottomTabBarItem(
                          icon: const Icon(Icons.history_outlined),
                          title: Text(titles[1])),
                      BrnBottomTabBarItem(
                          icon: const Icon(Icons.account_circle_outlined),
                          title: Text(titles[2])),
                    ],
                  )
                ],
              );
            } else {
              return const LoginPage();
            }
          },
        ));
  }
}

class KeepAliveView extends StatefulWidget {
  final bool isKeepAlive;
  final Widget child;

  const KeepAliveView(
      {super.key, required this.isKeepAlive, required this.child});

  @override
  State<KeepAliveView> createState() => _KeepAliveViewState();
}

class _KeepAliveViewState extends State<KeepAliveView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  bool get wantKeepAlive => widget.isKeepAlive;
}
