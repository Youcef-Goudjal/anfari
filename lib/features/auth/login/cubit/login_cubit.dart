import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());

  void isDeveloperTapped() {
    emit(state.copyWith(
      isDeveloper: true,
    ));
  }

  void isUserTapped() {
    emit(state.copyWith(
      isDeveloper: false,
    ));
  }

  void phoneChanged(String value) {
    final phone = Phone.dirty(value);
    emit(
      state.copyWith(
        phone: phone,
        status: Formz.validate([phone]),
      ),
    );
  }
}
