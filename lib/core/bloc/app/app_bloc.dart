import 'dart:async';

import 'package:anfari/core/extensions/extensions.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc(
    this._authenticationRepository,
  ) : super(const AppState.uninitialized()) {
    on<AppStarted>(_onAppStarted);
    on<AppUserChanged>(_onUserChanged);
    on<AppLogoutRequested>(_onLogoutRequested);
    _userSubscription = _authenticationRepository.user.listen(
      (user) => add(AppUserChanged(user)),
    );
  }

  final AuthenticationRepository _authenticationRepository;

  late final StreamSubscription<User> _userSubscription;

  void _onUserChanged(AppUserChanged event, Emitter<AppState> emit) {
    emit(
      event.user.isNotEmpty
          ? AppState.authenticated(event.user)
          : const AppState.unauthenticated(),
    );
  }

  void _onLogoutRequested(AppLogoutRequested event, Emitter<AppState> emit) {
    unawaited(_authenticationRepository.logOut());
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }

  void _onAppStarted(AppStarted event, Emitter<AppState> emit) async {
    try {
      // setup settings (get old settings)

      bool isLoggedIn = _authenticationRepository.currentUser.isNotEmpty;
      // For display splash screen
      await Future.delayed(3.seconds);
      if (isLoggedIn) {
        emit(AppState.authenticated(_authenticationRepository.currentUser));
      } else {
        emit(const AppState.unauthenticated());
      }
    } catch (e) {
      emit(const AppState.unauthenticated());
    }
  }
}
