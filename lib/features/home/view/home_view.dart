import 'package:anfari/core/manager/route/router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/bloc/bloc.dart';
import '../../../core/manager/language/locale_keys.g.dart';

class HomePage extends StatelessWidget {
  static Page<void> page() => const MaterialPage(child: HomePage());

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileNotRegistred) {
          Navigator.pushNamed(context, AppRouter.register);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            LocaleKeys.anfari.tr(),
          ),
          actions: [
            IconButton(
              onPressed: () {
                context.read<AuthenticationBloc>().add(LoggedOut());
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.red,
              ),
            )
          ],
        ),
        backgroundColor: Colors.amber,
      ),
    );
  }
}
