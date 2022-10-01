import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storage_repository/storage_repository.dart';
import 'package:user_repository/user_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;
  final StorageRepository _storageRepository;
  StreamSubscription? _profileStreamSub;
  User loggedUser;
  bool isDeveloper = false;

  ProfileBloc(
    AuthenticationRepository authenticationRepository,
    UserRepository userRepository,
    StorageRepository storageRepository,
  )   : _authenticationRepository = authenticationRepository,
        _userRepository = userRepository,
        _storageRepository = storageRepository,
        loggedUser = User(id: authenticationRepository.currentUser.id),
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

  /// load the user avar then update the user
  FutureOr<void> _onUploadAvatar(
      UploadAvatar event, Emitter<ProfileState> emit) async {
    try {
      // Get image url from firebase storage
      String imageUrl = await _storageRepository.uploadImageData(
        "users/profile/${loggedUser.id}",
        event.imageFile,
      );
      // update the user
      var updatedUser = loggedUser.copyWith(photo: imageUrl);
      await _userRepository.updateUserData(updatedUser);
    } catch (e) {
      print("profile bloc error uploading ");
      emit(ProfileLoadFailure(e.toString()));
    }
  }

  FutureOr<void> _onProfileUpdated(
      ProfileUpdated event, Emitter<ProfileState> emit) {
    try {
      if (event.updatedUser.isEmpty) {
        emit(ProfileNotRegistred());
      } else {
        loggedUser = event.updatedUser;
        emit(ProfileLoaded(event.updatedUser));
      }
    } catch (e) {
      emit(ProfileLoadFailure(e.toString()));
    }
  }

  @override
  Future<void> close() {
    loggedUser = User.empty;
    _profileStreamSub?.cancel();
    return super.close();
  }
}
