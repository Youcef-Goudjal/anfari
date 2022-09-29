import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(const RegisterState());

  void usernameChanged(String value) {
    final username = Username.dirty(value: value);
    emit(
      state.copyWith(
        username: username,
        status: Formz.validate([username]),
      ),
    );
  }

  void facultyChanged(String value) {
    emit(state.copyWith(
      faculty: value,
    ));
  }

  void universityChanged(String value) {
    emit(state.copyWith(
      university: value,
    ));
  }

  void specialityChanged(String value) {
    emit(state.copyWith(
      speciality: value,
    ));
  }

  void pickImage() {
    print("piking image");
  }
}
