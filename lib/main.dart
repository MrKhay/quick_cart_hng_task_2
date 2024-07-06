import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'features/features.dart';
import 'quick_cart.dart';

void main() {
  runApp(const ProviderScope(
    child: MainApp(),
  ));
}

///
class MainApp extends StatelessWidget {
  ///
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: kAppName,
      themeMode: ThemeMode.system,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      home: const QuickCart(),
    );
  }
}
