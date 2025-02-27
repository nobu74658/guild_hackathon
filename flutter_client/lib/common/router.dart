import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:knitting/view/knitting_pattern/knitting_pattern_screen.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'initial',
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: const KnittingPatternScreen(),
        );
      },
    ),
  ],
);
