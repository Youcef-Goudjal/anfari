import 'package:anfari/core/bloc/application/application_bloc.dart';
import 'package:anfari/core/bloc/authentication/authentication_bloc.dart';
import 'package:anfari/core/bloc/language/language_bloc.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommonBloc {
  //Bloc
  static final applicationBloc = ApplicationBloc();
  static final authenticationBloc = AuthenticationBloc(
    AuthenticationRepository(),
  );
  static final languageBloc = LanguageBloc();

  static List<BlocProvider> get blocProviders => [
        BlocProvider<ApplicationBloc>(create: (context) => applicationBloc),
        BlocProvider<AuthenticationBloc>(
            create: (context) => authenticationBloc),
        BlocProvider<LanguageBloc>(create: (context) => languageBloc),
      ];
  static void dispose() {
    applicationBloc.close();
    authenticationBloc.close();
    languageBloc.close();
  }
}
