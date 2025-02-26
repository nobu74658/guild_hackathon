import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knitting/account/authentication.dart';
import 'package:knitting/common/theme.dart';
import 'package:knitting/firebase_options.dart';
import 'package:knitting/view/knitting_pattern/knitting_pattern_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final User? _ = await Authentication.signInAnonymously();

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
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
