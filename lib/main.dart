import 'package:flutter/material.dart';
import 'package:sdi_hybrid/tabs/layout.dart';
import 'package:sdi_hybrid/utils/http.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDio();
  runApp(const MyApp());
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
