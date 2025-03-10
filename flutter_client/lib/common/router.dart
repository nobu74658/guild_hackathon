import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image/image.dart' as img;
import 'package:knitting/model/types/knitting_type.dart';
import 'package:knitting/view/knitting_pattern/knitting_pattern_screen.dart';
import 'package:knitting/view/knitting_pattern_list/knitting_pattern_list_screen.dart';
import 'package:knitting/view/palette_list/palette_list_screen.dart';

part 'router.g.dart';

@TypedGoRoute<KnittingPatternListRoute>(path: '/')
class KnittingPatternListRoute extends GoRouteData {
  const KnittingPatternListRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const KnittingPatternListScreen();
  }
}

@TypedGoRoute<PaletteListRoute>(path: ConnectedPaletteListScreen.path)
class PaletteListRoute extends GoRouteData {
  const PaletteListRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ConnectedPaletteListScreen();
  }
}

class KnittingPatternRouteData {
  const KnittingPatternRouteData({
    required this.projectId,
    required this.imagePath,
    required this.image,
    required this.knittingType,
    required this.colorPalette,
  });

  final int? projectId;
  final String? imagePath;
  final img.Image image;
  final KnittingType knittingType;
  final List<Color> colorPalette;
}

@TypedGoRoute<KnittingPatternRoute>(path: ConnectedKnittingPatternScreen.path)
class KnittingPatternRoute extends GoRouteData {
  const KnittingPatternRoute({
    required this.$extra,
  });

  final KnittingPatternRouteData $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ConnectedKnittingPatternScreen(
      projectId: $extra.projectId,
      imagePath: $extra.imagePath,
      image: $extra.image,
      knittingType: $extra.knittingType,
      backgroundColor: Colors.grey[300],
      colorPalette: $extra.colorPalette,
    );
  }
}

@TypedGoRoute<DebugKnittingPatternRoute>(path: DebugKnittingPatternScreen.path)
class DebugKnittingPatternRoute extends GoRouteData {
  const DebugKnittingPatternRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return DebugKnittingPatternScreen(
      projectId: null,
      imagePath: null,
      knittingType: KnittingType.singleCrochet,
      backgroundColor: Colors.grey[300],
      colorPalette: const [
        Colors.red,
        Colors.blue,
        Colors.green,
        Colors.yellow,
        Colors.purple,
        Colors.orange,
      ],
    );
  }
}

final router = GoRouter(
  initialLocation: '/',
  routes: $appRoutes,
);
