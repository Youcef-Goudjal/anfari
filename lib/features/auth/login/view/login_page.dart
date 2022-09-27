import 'package:anfari/core/extensions/context_extension.dart';
import 'package:anfari/core/manager/route/app_router.gr.dart';
import 'package:anfari/features/auth/login/bloc/phone_auth_bloc.dart';
import 'package:anfari/features/auth/login/view/otp_form.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../login.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => OtpCubit()),
        BlocProvider(create: (context) => PhoneAuthBloc(context.read())),
      ],
      child: Scaffold(
        body: BlocListener<PhoneAuthBloc, PhoneAuthState>(
          listener: (context, state) {
            if (state is PhoneAuthVerified) {
              context.router.popAndPush(const HomeRoute());
            }

            // show error message if any error occurs while verifing phone number and otp code.
            if (state is PhoneAuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.error,
                  ),
                  backgroundColor: context.theme.errorColor,
                ),
              );
            }
          },
          child: BlocBuilder<PhoneAuthBloc, PhoneAuthState>(
            builder: (context, state) {
              if (state is PhoneAuthLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is! PhoneAuthCodeSentSuccess) {
                return const LoginForm();
              } else {
                return OtpForm(
                  verificationId: state.verificationId,
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
