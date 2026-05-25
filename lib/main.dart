import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'presentation/home_page.dart';

void main() {
  runApp(const Portfolio());
}

class Portfolio extends StatelessWidget {
  const Portfolio({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fatma Atef | Flutter Developer',
      theme: AppTheme.dark,
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
