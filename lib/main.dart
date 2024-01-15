import 'package:flutter/material.dart';
import 'package:sdi_hybrid/tabs/layout.dart';

import 'common/global.dart';

Future<void> main() async {
  Global.init().then((e) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SDI',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const LayoutPage(title: "Mildew Identifier"),
    );
  }
}
