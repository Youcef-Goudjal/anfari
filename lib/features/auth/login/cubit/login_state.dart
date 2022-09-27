part of 'login_cubit.dart';

class LoginState extends Equatable {
  const LoginState({
    this.phone = const Phone.pure(),
    this.status = FormzStatus.pure,
    this.errorMessage,
  });

  final Phone phone;
  final FormzStatus status;
  final String? errorMessage;

  @override
  List<Object> get props => [phone, status];
  LoginState copyWith({
    Phone? phone,
    FormzStatus? status,
    String? errorMessage,
  }) {
    return LoginState(
      phone: phone ?? this.phone,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
