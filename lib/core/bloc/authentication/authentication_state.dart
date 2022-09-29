part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class UnInitialized extends AuthenticationState {}

class Authenticated extends AuthenticationState {}

class UnAuthenticated extends AuthenticationState {}
