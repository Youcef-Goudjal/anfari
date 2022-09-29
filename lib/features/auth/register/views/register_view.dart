import 'package:anfari/features/auth/register/cubit/register_cubit.dart';
import 'package:anfari/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

import 'register_form.dart';

class RegisterPage extends StatelessWidget {
  static Page<void> page() => const MaterialPage(child: RegisterPage());

  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(getIt<UserRepository>()),
      child: const Scaffold(
        body: RegisterForm(),
      ),
    );
  }
}
