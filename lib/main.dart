import 'package:flutter/material.dart';
import 'pages/saas_landing_page.dart';
import 'pages/demo_page.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const PizzaNovaApp());
}

class PizzaNovaApp extends StatelessWidget {
  const PizzaNovaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PizzaNova',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: const SaasLandingPage(),
      routes: {
        '/demo': (context) => const DemoPage(),
      },
    );
  }
}
