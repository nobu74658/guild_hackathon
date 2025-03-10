// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $knittingPatternListRoute,
      $paletteListRoute,
      $knittingPatternRoute,
      $debugKnittingPatternRoute,
    ];

RouteBase get $knittingPatternListRoute => GoRouteData.$route(
      path: '/',
      factory: $KnittingPatternListRouteExtension._fromState,
    );

extension $KnittingPatternListRouteExtension on KnittingPatternListRoute {
  static KnittingPatternListRoute _fromState(GoRouterState state) =>
      const KnittingPatternListRoute();

  String get location => GoRouteData.$location(
        '/',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $paletteListRoute => GoRouteData.$route(
      path: '/palette',
      factory: $PaletteListRouteExtension._fromState,
    );

extension $PaletteListRouteExtension on PaletteListRoute {
  static PaletteListRoute _fromState(GoRouterState state) =>
      const PaletteListRoute();

  String get location => GoRouteData.$location(
        '/palette',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $knittingPatternRoute => GoRouteData.$route(
      path: '/edit',
      factory: $KnittingPatternRouteExtension._fromState,
    );

extension $KnittingPatternRouteExtension on KnittingPatternRoute {
  static KnittingPatternRoute _fromState(GoRouterState state) =>
      KnittingPatternRoute(
        $extra: state.extra as KnittingPatternRouteData,
      );

  String get location => GoRouteData.$location(
        '/edit',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) =>
      context.replace(location, extra: $extra);
}

RouteBase get $debugKnittingPatternRoute => GoRouteData.$route(
      path: '/debug-edit',
      factory: $DebugKnittingPatternRouteExtension._fromState,
    );

extension $DebugKnittingPatternRouteExtension on DebugKnittingPatternRoute {
  static DebugKnittingPatternRoute _fromState(GoRouterState state) =>
      const DebugKnittingPatternRoute();

  String get location => GoRouteData.$location(
        '/debug-edit',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
