part of 'login_cubit.dart';

class LoginState extends Equatable {
  const LoginState(
      {this.phone = const Phone.pure(),
      this.status = FormzStatus.pure,
      this.errorMessage,
      this.isDeveloper = false});

  final Phone phone;
  final FormzStatus status;
  final String? errorMessage;
  final bool isDeveloper;

  @override
  List<Object> get props => [phone, status, isDeveloper];
  LoginState copyWith({
    Phone? phone,
    FormzStatus? status,
    String? errorMessage,
    bool? isDeveloper,
  }) {
    return LoginState(
      phone: phone ?? this.phone,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      isDeveloper: isDeveloper ?? this.isDeveloper,
    );
  }
}
