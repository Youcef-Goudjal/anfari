import 'dart:async';
import 'dart:io';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;
  StreamSubscription? _profileStreamSub;
  User? _loggedUser;

  ProfileBloc(
    AuthenticationRepository authenticationRepository,
    UserRepository userRepository,
  )   : _authenticationRepository = authenticationRepository,
        _userRepository = userRepository,
        super(ProfileLoading()) {
    on<LoadProfile>(_onLoadProfile);
    on<UploadAvatar>(_onUploadAvatar);
    on<ProfileUpdated>(_onProfileUpdated);
  }
  // Load profile
  FutureOr<void> _onLoadProfile(LoadProfile event, Emitter<ProfileState> emit) {
    try {
      _profileStreamSub?.cancel();
      _profileStreamSub = _userRepository
          .loggedUserStream(_authenticationRepository.currentUser)
          .listen(
        (updatedUser) {
          add(ProfileUpdated(updatedUser));
        },
      );
    } catch (e) {
      emit(ProfileLoadFailure(e.toString()));
    }
  }

  FutureOr<void> _onUploadAvatar(
      UploadAvatar event, Emitter<ProfileState> emit) {}

  FutureOr<void> _onProfileUpdated(
      ProfileUpdated event, Emitter<ProfileState> emit) {
    try {
      _loggedUser = event.updatedUser;
      emit(ProfileLoaded(event.updatedUser));
    } catch (e) {
      emit(ProfileLoadFailure(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _loggedUser = null;
    _profileStreamSub?.cancel();
    return super.close();
  }
}
