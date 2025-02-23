import 'package:flutter/material.dart';
import 'package:knitting/common/theme.dart';
import 'package:knitting/view/knitting_pattern/knitting_pattern_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.get,
      home: const KnittingPatternScreen(),
    );
  }
}
