part of 'register_cubit.dart';

class RegisterState extends Equatable {
  const RegisterState({
    this.username = const Username.pure(),
    this.faculty = "",
    this.university = "",
    this.speciality = "",
    this.file,
    this.imageUrl = "",
    this.status = FormzStatus.pure,
    this.errorMessage,
  });

  final Username username;
  final String university, faculty, speciality;
  final File? file;
  final String imageUrl;
  final FormzStatus status;
  final String? errorMessage;
  @override
  List<Object> get props => [username, university, faculty, speciality, status];

  RegisterState copyWith({
    Username? username,
    String? university,
    String? faculty,
    String? speciality,
    String? imageUrl,
    File? file,
    FormzStatus? status,
    String? errorMessage,
  }) =>
      RegisterState(
        username: username ?? this.username,
        university: university ?? this.university,
        faculty: faculty ?? this.faculty,
        speciality: speciality ?? this.speciality,
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
        file: file ?? this.file,
        imageUrl: imageUrl ?? this.imageUrl,
      );
}
