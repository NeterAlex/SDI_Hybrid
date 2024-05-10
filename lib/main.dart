import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sdi_hybrid/layout.dart';
import 'package:sdi_hybrid/state/flow_provider.dart';
import 'package:sdi_hybrid/state/user_provider.dart';

import 'common/global.dart';

Future<void> main() async {
  Global.init().then((e) => runApp(MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => UserProvider()),
          ChangeNotifierProvider(create: (context) => FlowProvider())
        ],
        child: const MyApp(),
      )));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    BrnInitializer.register(
        allThemeConfig: BrnAllThemeConfig(
            commonConfig:
                BrnCommonConfig(brandPrimary: const Color(0xFF248700)),
            dialogConfig: BrnDialogConfig(radius: 12.0)));
    return MaterialApp(
      title: 'SDI',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const LayoutPage(title: "大豆病害检测"),
    );
  }
}
