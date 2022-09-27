import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  OtpCubit() : super(const OtpState());

  void otpChanged(String value) {
    emit(state.copyWith(
      otp: value,
    ));
  }
}
