import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image/image.dart' as img;
import 'package:knitting/model/entities/color_palette.dart';
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
    required this.image,
    required this.knittingType,
    required this.colorPalette,
  });

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
      image: $extra.image,
      knittingType: KnittingType.fromValue($extra.knittingType.value),
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
      // ここで変更できる
      knittingType: KnittingType.singleCrochetPurl,
      backgroundColor: Colors.grey[300],
      colorPalette: ColorPalette.mock.paletteColors,
    );
  }
}

final router = GoRouter(
  initialLocation: '/',
  routes: $appRoutes,
);
