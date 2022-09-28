import 'package:anfari/core/bloc/app/app_bloc.dart';
import 'package:anfari/core/bloc/common_bloc.dart';
import 'package:anfari/core/manager/route/router.dart';
import 'package:anfari/core/utils/bloc_observer.dart';
import 'package:anfari/product/firebase_options.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/manager/language/language_manager.dart';
import 'core/manager/theme/theme_manager.dart';
import 'product/constants/string_constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    EasyLocalization(
      supportedLocales: LanguageManager.instance.supportedLocales,
      path: LanguageManager.instance.path,
      startLocale: LanguageManager.instance.ar,
      saveLocale: true,
      useOnlyLangCode: true,
      fallbackLocale: LanguageManager.instance.ar,
      child: ScreenUtilInit(
        designSize: const Size(428, 926),
        minTextAdapt: true,
        builder: (context, child) {
          return MultiBlocProvider(
            providers: CommonBloc.blocProviders,
            child: const Anfari(),
          );
        },
      ),
    ),
  );
}

class Anfari extends StatefulWidget {
  const Anfari({super.key});

  @override
  State<Anfari> createState() => _AnfariState();
}

class _AnfariState extends State<Anfari> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState? get _navigator => _navigatorKey.currentState;

  @override
  void initState() {
    CommonBloc.appBloc.add(AppStarted());
    super.initState();
  }

  @override
  void dispose() {
    CommonBloc.dispose();
    super.dispose();
  }

  void onNavigate(String route) {
    _navigator!.pushNamedAndRemoveUntil(route, (route) => false);
  }

  void loadData() {
    // load data when authenticated
    //TODO:
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // app name
      title: StringConstants.title,

      //theme
      themeMode: ThemeMode.system,
      theme: ThemeManager.instance.lightTheme,
      darkTheme: ThemeManager.instance.darkTheme,

      // localization
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,

      //routing
      navigatorKey: _navigatorKey,
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: AppRouter.splash,
      builder: (context, child) {
        return BlocListener<AppBloc, AppState>(
          listener: (context, state) {
            if (state.isAuthenticated) {
              loadData();
              onNavigate(AppRouter.home);
            } else if (state.isUnAuthenticated) {
              onNavigate(AppRouter.boarding);
            } else {
              onNavigate(AppRouter.splash);
            }
          },
          child: child,
        );
      },
    );
  }
}
