import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:knitting/view/knitting_pattern/knitting_pattern_screen.dart';
import 'package:knitting/view/knitting_pattern_list/knitting_pattern_list_screen.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: const KnittingPatternListScreen(),
        );
      },
    ),
    GoRoute(
      path: KnittingPatternScreen.path,
      pageBuilder: (context, state) {
        final size = state.uri.queryParameters['size'] ?? '8*8';
        final knittingType =
            state.uri.queryParameters['knittingType'] ?? 'メリヤス編み';

        debugPrint('size: $size, knittingType: $knittingType');

        return MaterialPage(
          key: state.pageKey,
          child: const KnittingPatternScreen(),
        );
      },
    ),
  ],
);
