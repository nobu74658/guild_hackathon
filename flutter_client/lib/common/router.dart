import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image/image.dart' as img;
import 'package:knitting/model/types/knitting_type.dart';
import 'package:knitting/view/knitting_pattern/knitting_pattern_screen.dart';
import 'package:knitting/view/knitting_pattern_list/knitting_pattern_list_screen.dart';

part 'router.g.dart';

@TypedGoRoute<KnittingPatternListRoute>(path: '/')
class KnittingPatternListRoute extends GoRouteData {
  const KnittingPatternListRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const KnittingPatternListScreen();
  }
}

@TypedGoRoute<KnittingPatternRoute>(path: ConnectedKnittingPatternScreen.path)
class KnittingPatternRoute extends GoRouteData {
  const KnittingPatternRoute({
    required this.$extra,
    required this.knittingType,
  });

  final Object $extra;
  final String? knittingType;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    if ($extra is! img.Image) {
      throw Exception('extra is null');
    }
    return ConnectedKnittingPatternScreen(
      image: $extra as img.Image,
      knittingType: KnittingType.fromValue(knittingType ?? ''),
      backgroundColor: Colors.grey[300],
    );
  }
}

@TypedGoRoute<DebugKnittingPatternRoute>(path: DebugKnittingPatternScreen.path)
class DebugKnittingPatternRoute extends GoRouteData {
  const DebugKnittingPatternRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return DebugKnittingPatternScreen(
      knittingType: KnittingType.singleCrochet,
      backgroundColor: Colors.grey[300],
    );
  }
}

final router = GoRouter(
  initialLocation: '/',
  routes: $appRoutes,
);
