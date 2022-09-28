part of 'app_bloc.dart';

enum AppStatus {
  authenticated,
  unauthenticated,
  unInitialized,
}

class AppState extends Equatable {
  const AppState._({
    required this.status,
    this.user = User.empty,
  });

  const AppState.authenticated(User user)
      : this._(status: AppStatus.authenticated, user: user);

  const AppState.unauthenticated() : this._(status: AppStatus.unauthenticated);
  const AppState.uninitialized() : this._(status: AppStatus.unInitialized);
  final AppStatus status;
  final User user;
  bool get isAuthenticated => status == AppStatus.authenticated;
  bool get isUnAuthenticated => status == AppStatus.unauthenticated;
  bool get isUnInitialized => status == AppStatus.unInitialized;

  @override
  List<Object> get props => [status, user];
}
