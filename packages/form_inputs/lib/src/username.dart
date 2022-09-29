import 'package:formz/formz.dart';

/// class that validate username
class Username extends FormzInput<String, UsernameError> {
  ///
  const Username.pure({String value = ''}) : super.pure(value);

  ///
  const Username.dirty({String value = ''}) : super.dirty(value);

  @override
  UsernameError? validator(String value) {
    return value.isEmpty ? UsernameError.empty : null;
  }
}

/// when the user is [empty]
enum UsernameError {
  /// value == ""
  empty
}
