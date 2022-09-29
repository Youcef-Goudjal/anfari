import 'package:anfari/features/auth/boarding/views/boarding_view.dart';
import 'package:anfari/features/auth/login/view/view.dart';
import 'package:anfari/features/auth/register/views/register_view.dart';
import 'package:anfari/features/home/home.dart';
import 'package:anfari/features/splash/splash_view.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static const root = "/";
  static const splash = "/splash";
  static const login = "/login";
  static const register = "/register";
  static const home = "/home";
  static const boarding = "/boarding";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case root:
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterPage());
      case home:
        return MaterialPageRoute(builder: (_) => const HomePage());

      case boarding:
        return MaterialPageRoute(builder: (_) => const BoardingPage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text("No route defined for (${settings.name})"),
            ),
          ),
        );
    }
  }

  static final AppRouter _instance = AppRouter._internal();

  factory AppRouter() {
    return _instance;
  }

  AppRouter._internal();
}
