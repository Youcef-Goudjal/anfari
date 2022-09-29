part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final User loggedUser;

  const ProfileLoaded(this.loggedUser);
  @override
  List<Object> get props => [loggedUser];
}

class ProfileLoadFailure extends ProfileState {
  final String error;

  const ProfileLoadFailure(this.error);
  @override
  List<Object> get props => [error];
}
