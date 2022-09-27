// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/material.dart' as _i7;

import '../../../features/auth/boarding/boarding.dart' as _i2;
import '../../../features/auth/login/view/view.dart' as _i3;
import '../../../features/auth/register/register.dart' as _i4;
import '../../../features/home/home.dart' as _i5;
import '../../../features/splash/splash_view.dart' as _i1;

class AppRouter extends _i6.RootStackRouter {
  AppRouter([_i7.GlobalKey<_i7.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    SplashRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.SplashView(),
      );
    },
    BoardingRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.BoardingView(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.LoginPage(),
      );
    },
    RegisterRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.RegisterView(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.HomeView(),
      );
    },
  };

  @override
  List<_i6.RouteConfig> get routes => [
        _i6.RouteConfig(
          SplashRoute.name,
          path: '/',
        ),
        _i6.RouteConfig(
          BoardingRoute.name,
          path: '/boarding',
        ),
        _i6.RouteConfig(
          LoginRoute.name,
          path: '/login',
        ),
        _i6.RouteConfig(
          RegisterRoute.name,
          path: '/register',
        ),
        _i6.RouteConfig(
          HomeRoute.name,
          path: '/home',
        ),
      ];
}

/// generated route for
/// [_i1.SplashView]
class SplashRoute extends _i6.PageRouteInfo<void> {
  const SplashRoute()
      : super(
          SplashRoute.name,
          path: '/',
        );

  static const String name = 'SplashRoute';
}

/// generated route for
/// [_i2.BoardingView]
class BoardingRoute extends _i6.PageRouteInfo<void> {
  const BoardingRoute()
      : super(
          BoardingRoute.name,
          path: '/boarding',
        );

  static const String name = 'BoardingRoute';
}

/// generated route for
/// [_i3.LoginPage]
class LoginRoute extends _i6.PageRouteInfo<void> {
  const LoginRoute()
      : super(
          LoginRoute.name,
          path: '/login',
        );

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i4.RegisterView]
class RegisterRoute extends _i6.PageRouteInfo<void> {
  const RegisterRoute()
      : super(
          RegisterRoute.name,
          path: '/register',
        );

  static const String name = 'RegisterRoute';
}

/// generated route for
/// [_i5.HomeView]
class HomeRoute extends _i6.PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: '/home',
        );

  static const String name = 'HomeRoute';
}
