import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sdi_hybrid/layout.dart';
import 'package:sdi_hybrid/state/user_provider.dart';

import 'common/global.dart';

Future<void> main() async {
  Global.init().then((e) => runApp(ChangeNotifierProvider(
        create: (context) => UserProvider(),
        child: const MyApp(),
      )));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SDI',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: false,
      ),
      home: const LayoutPage(title: "Mildew Identifier"),
    );
  }
}
