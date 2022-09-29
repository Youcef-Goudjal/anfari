import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:user_repository/user_repository.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  ImagePicker picker = ImagePicker();
  final UserRepository _userRepository;
  RegisterCubit(UserRepository repository)
      : _userRepository = repository,
        super(const RegisterState());

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

  void pickImage() async {
    print("piking image");

    final file = await picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      emit(
        state.copyWith(
          file: await file.readAsBytes(),
        ),
      );
    }
  }

  Future<void> save(User currentUser) async {
    await _userRepository.updateUserData(
      currentUser.copyWith(
        name: state.username.value,
      ),
      additionalData: {
        "University": state.university,
        "Faculty": state.faculty,
        "Speciality": state.speciality,
      },
    );
  }
}
