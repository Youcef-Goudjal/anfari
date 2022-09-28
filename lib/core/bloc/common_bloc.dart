import 'package:anfari/core/bloc/app/app_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommonBloc {
  /// Bloc
  static final AppBloc appBloc = AppBloc();

  static final List<BlocProvider> blocProviders = [
    BlocProvider<AppBloc>(create: (context) => appBloc),
  ];

  static void dispose() {
    appBloc.close();
  }

  /// Singleton factory
  static final CommonBloc _instance = CommonBloc._internal();

  factory CommonBloc() {
    return _instance;
  }
  CommonBloc._internal();
}
