import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:knitting/view/knitting_pattern/knitting_pattern_screen.dart';
import 'package:knitting/view/knitting_pattern_list/knitting_pattern_list_screen.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'initial',
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: const KnittingPatternListScreen(),
        );
      },
    ),
    GoRoute(
      path: '/edit',
      name: 'edit',
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: const KnittingPatternScreen(),
        );
      },
    ),
  ],
);
