part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

// load profile of logged firebase user in firestore
class LoadProfile extends ProfileEvent {}

/// Upload user avatar
class UploadAvatar extends ProfileEvent {
  final Uint8List imageFile;

  const UploadAvatar(this.imageFile);
  @override
  List<Object> get props => [imageFile];
}

/// profile was updated
class ProfileUpdated extends ProfileEvent {
  final User updatedUser;

  const ProfileUpdated(this.updatedUser);

  @override
  List<Object> get props => [updatedUser];
}
