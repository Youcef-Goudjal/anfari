import 'dart:async';

import 'package:anfari/core/extensions/extensions.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository _authenticationRepository;

  late final StreamSubscription<User> _userSubscription;
  AuthenticationBloc(AuthenticationRepository authenticationRepository)
      : _authenticationRepository = authenticationRepository,
        super(
          authenticationRepository.currentUser.isNotEmpty
              ? Authenticated()
              : UnAuthenticated(),
        ) {
    on<AuthenticationStarted>(_onAuthenticationStarted);
    on<LoggedIn>(_onLoggedIn);
    on<LoggedOut>(_onLoggedOut);
    on<UserStateChanged>(_onUserStateChanged);
    _userSubscription = authenticationRepository.user.listen((user) {
      if (i == 0) {
        i++;
      } else {
        add(UserStateChanged(user));
      }
    });
  }
  int i = 0;
  FutureOr<void> _onAuthenticationStarted(
      AuthenticationStarted event, Emitter<AuthenticationState> emit) async {
    bool isLoggedIn = _authenticationRepository.isLoggedIn();

    // for display splash screen
    await Future.delayed(1.seconds);
    if (isLoggedIn) {
      emit(Authenticated());
    } else {
      emit(UnAuthenticated());
    }
  }

  FutureOr<void> _onLoggedIn(
      LoggedIn event, Emitter<AuthenticationState> emit) {}

  FutureOr<void> _onLoggedOut(
      LoggedOut event, Emitter<AuthenticationState> emit) {
    unawaited(_authenticationRepository.logOut());
  }

  FutureOr<void> _onUserStateChanged(
      UserStateChanged event, Emitter<AuthenticationState> emit) {
    if (event.user.isEmpty) {
      emit(UnAuthenticated());
    } else {
      emit(Authenticated());
    }
  }
}
