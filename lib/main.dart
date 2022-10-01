import 'package:anfari/core/manager/route/router.dart';
import 'package:anfari/core/manager/theme/theme_manager.dart';
import 'package:anfari/product/firebase_options.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:posts_repository/posts_repository.dart';
import 'package:storage_repository/storage_repository.dart';
import 'package:university_repository/university_repository.dart';
import 'package:user_repository/user_repository.dart';

import 'core/bloc/bloc.dart';
import 'core/configs/application.dart';
import 'core/manager/language/language_manager.dart';
import 'core/utils/bloc_observer.dart';
import 'product/constants/string_constants.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton(AuthenticationRepository());
  getIt.registerSingleton<UserRepository>(FirebaseUserRepository());
  getIt.registerSingleton<StorageRepository>(FirebaseStorageImpl());
  getIt.registerSingleton<PostRepository>(PostsRepositoryImpl());
  getIt.registerSingleton<UniversityRepository>(UniversityRepositoryImpl());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
  Bloc.observer = AppBlocObserver();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setup();
  await EasyLocalization.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      supportedLocales: LanguageManager.instance.supportedLocales,
      path: LanguageManager.instance.path,
      startLocale: LanguageManager.instance.ar,
      saveLocale: true,
      useOnlyLangCode: true,
      fallbackLocale: LanguageManager.instance.ar,
      child: ScreenUtilInit(
        designSize: const Size(428, 926),
        builder: (context, child) {
          return MultiBlocProvider(
            providers: CommonBloc.blocProviders,
            child: const Anfari(),
          );
        },
      ),
    );
  }
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
    CommonBloc.applicationBloc.add(SetupApplication());
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
    // Only load data when authenticated
    context.read<ProfileBloc>().add(LoadProfile());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApplicationBloc, ApplicationState>(
      builder: (context, applicationState) {
        return MaterialApp(
          navigatorKey: _navigatorKey,
          debugShowCheckedModeBanner: Application.debug,
          //app name
          title: StringConstants.title,
          //theme
          themeMode: ThemeMode.light,
          theme: ThemeManager.instance.lightTheme,
          darkTheme: ThemeManager.instance.darkTheme,

          // localization
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          //routing
          onGenerateRoute: AppRouter.generateRoute,
          initialRoute: AppRouter.splash,
          builder: (context, child) {
            return BlocListener<AuthenticationBloc, AuthenticationState>(
              listener: (context, authState) {
                if (applicationState is ApplicationCompleted) {
                  if (authState is UnAuthenticated) {
                    onNavigate(AppRouter.boarding);
                  } else if (authState is UnInitialized) {
                    onNavigate(AppRouter.splash);
                  } else if (authState is Authenticated) {
                    loadData();
                    onNavigate(AppRouter.home);
                  }
                } else {
                  onNavigate(AppRouter.splash);
                }
              },
              child: child,
            );
          },
        );
      },
    );
  }
}
