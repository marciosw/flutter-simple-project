import 'package:flutter/material.dart';
import 'package:healthcare/service_locator.dart';
import 'package:healthcare/start/alpha.page.dart';

Future<void> main() async {
  await ServiceLocatorConfig.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Health',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const AlphaPage(),
    );
  }
}
