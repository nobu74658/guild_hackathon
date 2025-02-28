// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $knittingPatternListRoute,
      $knittingPatternRoute,
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

RouteBase get $knittingPatternRoute => GoRouteData.$route(
      path: '/edit',
      factory: $KnittingPatternRouteExtension._fromState,
    );

extension $KnittingPatternRouteExtension on KnittingPatternRoute {
  static KnittingPatternRoute _fromState(GoRouterState state) =>
      KnittingPatternRoute(
        knittingType: state.uri.queryParameters['knitting-type'],
        $extra: state.extra as Object,
      );

  String get location => GoRouteData.$location(
        '/edit',
        queryParams: {
          if (knittingType != null) 'knitting-type': knittingType,
        },
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) =>
      context.replace(location, extra: $extra);
}
