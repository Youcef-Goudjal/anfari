import 'package:anfari/core/extensions/extensions.dart';
import 'package:anfari/features/auth/login/bloc/phone_auth_bloc.dart';
import 'package:anfari/features/auth/login/login.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

import '../../../../core/manager/language/locale_keys.g.dart';

class OtpForm extends StatelessWidget {
  const OtpForm({
    Key? key,
    required this.verificationId,
  }) : super(key: key);

  final String verificationId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 43.w,
        vertical: 55.h,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: () {
                  context.router.pop();
                },
                icon: const FaIcon(
                  FontAwesomeIcons.chevronRight,
                  size: 29,
                  color: Colors.black,
                ),
              ),
            ),
            95.h.heightBox,
            Text(
              LocaleKeys.otp_title.tr(),
              style: context.textTheme.headline4,
            ),
            30.h.heightBox,
            Text(
              LocaleKeys.otp_desc.tr(),
              style: context.textTheme.headline5,
            ),
            179.h.heightBox,
            const _OtpField(),
            32.h.heightBox,
            _OtpVerifyBtn(
              verificationId: verificationId,
            ),
            16.h.heightBox,
            const _resendText()
          ],
        ),
      ),
    );
  }
}

class _resendText extends StatelessWidget {
  const _resendText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          LocaleKeys.otp_didntReceive.tr(),
          style: context.textTheme.headline5!.copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          LocaleKeys.otp_resend.tr(),
          style: context.textTheme.headline5!.copyWith(
            fontSize: 16.sp,
            color: context.theme.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}

class _OtpField extends StatelessWidget {
  const _OtpField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const length = 6;
    const borderColor = Color(0xffC9CBCB);
    const errorColor = Color(0xFFB00020);
    const fillColor = Color(0xffF8F8F8);
    final defaultPinTheme = PinTheme(
        width: 45.w,
        height: 59.h,
        textStyle: GoogleFonts.cairo(
          fontSize: 20.sp,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        decoration: BoxDecoration(
          color: fillColor,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: Colors.transparent),
        ));
    return Directionality(
      textDirection: TextDirection.ltr,
      child: SizedBox(
        height: 60.h,
        child: Pinput(
          length: length,
          defaultPinTheme: defaultPinTheme,
          focusedPinTheme: defaultPinTheme.copyDecorationWith(
            border: Border.all(color: context.theme.primaryColor),
          ),
          errorPinTheme: defaultPinTheme.copyDecorationWith(
            color: errorColor,
          ),
          onChanged: (otp) {
            context.read<OtpCubit>().otpChanged(otp);
          },
        ),
      ),
    );
  }
}

class _OtpVerifyBtn extends StatelessWidget {
  const _OtpVerifyBtn({
    Key? key,
    required this.verificationId,
  }) : super(key: key);

  final String verificationId;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.h,
      child: ElevatedButton(
        onPressed: () {
          final String otpCode = context.read<OtpCubit>().state.otp;

          context.read<PhoneAuthBloc>().add(
                VerifySentOtpEvent(
                    otpCode: otpCode, verificationId: verificationId),
              );
        },
        child: Center(
          child: Text(
            LocaleKeys.otp_verifyBtn.tr(),
            style: context.textTheme.headline2,
          ),
        ),
      ),
    );
  }
}
