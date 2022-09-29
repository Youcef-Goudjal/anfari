import 'package:anfari/core/bloc/authentication/authentication_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/manager/language/locale_keys.g.dart';

class HomePage extends StatelessWidget {
  static Page<void> page() => const MaterialPage(child: HomePage());

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
