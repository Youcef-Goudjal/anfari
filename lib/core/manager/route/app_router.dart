import 'package:anfari/features/auth/boarding/boarding.dart';
import 'package:anfari/features/auth/login/view/view.dart';
import 'package:anfari/features/auth/register/register.dart';
import 'package:anfari/features/home/home.dart';
import 'package:anfari/features/splash/splash_view.dart';
import 'package:auto_route/annotations.dart';

@MaterialAutoRouter(
  replaceInRouteName: "View|Page,Route",
  routes: <AutoRoute>[
    // app stack
    AutoRoute(
      path: "/",
      page: SplashView,
      initial: true,
    ),
    AutoRoute(
      path: "/boarding",
      page: BoardingView,
    ),
    AutoRoute(
      path: "/login",
      page: LoginPage,
    ),
    AutoRoute(
      path: "/register",
      page: RegisterView,
    ),

    AutoRoute(
      path: "/home",
      page: HomeView,
    ),
  ],
)
class $AppRouter {}
