import 'package:anfari/core/bloc/bloc.dart';
import 'package:anfari/main.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

class CommonBloc {
  //Bloc
  static final applicationBloc = ApplicationBloc();
  static final authenticationBloc = AuthenticationBloc(
    getIt<AuthenticationRepository>(),
  );
  static final languageBloc = LanguageBloc();
  static final profileBloc = ProfileBloc(
    getIt<AuthenticationRepository>(),
    getIt<UserRepository>(),
  );

  static List<BlocProvider> get blocProviders => [
        BlocProvider<ApplicationBloc>(
          create: (context) => applicationBloc,
        ),
        BlocProvider<AuthenticationBloc>(
          create: (context) => authenticationBloc,
        ),
        BlocProvider<LanguageBloc>(
          create: (context) => languageBloc,
        ),
        BlocProvider<ProfileBloc>(
          create: (context) => profileBloc,
        ),
      ];
  static void dispose() {
    applicationBloc.close();
    authenticationBloc.close();
    languageBloc.close();
    profileBloc.close();
  }
}
