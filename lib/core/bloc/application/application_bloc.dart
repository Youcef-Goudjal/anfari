import 'dart:async';

import 'package:anfari/core/bloc/authentication/authentication_bloc.dart';
import 'package:anfari/core/bloc/common_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../configs/application.dart';

part 'application_event.dart';
part 'application_state.dart';

class ApplicationBloc extends Bloc<ApplicationEvent, ApplicationState> {
  final Application application = Application();
  ApplicationBloc() : super(ApplicationInitial()) {
    on<SetupApplication>(_onSetupApplication);
  }

  FutureOr<void> _onSetupApplication(
      SetupApplication event, Emitter<ApplicationState> emit) async {
    await application.setPrefrences();

    // load old language

    CommonBloc.authenticationBloc.add(AuthenticationStarted());
    emit(ApplicationCompleted());
  }
}
