import 'package:anfari/core/utils/bloc_observer.dart';
import 'package:anfari/product/firebase_options.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/bloc/app_bloc.dart';
import 'core/manager/language/language_manager.dart';
import 'core/manager/route/app_router.gr.dart';
import 'core/manager/theme/theme_manager.dart';
import 'product/constants/string_constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final authenticationRepository = AuthenticationRepository();
  await authenticationRepository.user.first;
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
          return Anfari(
            authenticationRepository: authenticationRepository,
          );
        },
      ),
    ),
  );
}

class Anfari extends StatelessWidget {
  Anfari(
      {super.key, required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository;

  final _appRouter = AppRouter();
  final AuthenticationRepository _authenticationRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authenticationRepository,
      child: BlocProvider(
        create: (context) => AppBloc(
          authenticationRepository: _authenticationRepository,
        ),
        child: MaterialApp.router(
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

          // routing
          routerDelegate: _appRouter.delegate(),
          routeInformationParser: _appRouter.defaultRouteParser(),
        ),
      ),
    );
  }
}
