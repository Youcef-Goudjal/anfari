part of 'otp_cubit.dart';

class OtpState extends Equatable {
  const OtpState({
    this.otp = "",
    this.errorMessage,
  });

  final String otp;
  final String? errorMessage;

  OtpState copyWith({
    String? otp,
    String? errorMessage,
  }) {
    return OtpState(
      otp: otp ?? this.otp,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [otp];
}
