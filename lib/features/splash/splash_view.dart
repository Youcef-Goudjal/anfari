import 'package:anfari/core/extensions/extensions.dart';
import 'package:anfari/core/manager/route/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/bloc/app_bloc.dart';
import '../../core/manager/language/locale_keys.g.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppBloc, AppState>(
      listener: (context, state) async {
        Future.delayed(3.seconds).then((value) {
          context.router.replace(const BoardingRoute());
        });
      },
      child: Scaffold(
        backgroundColor: const Color(0xff15997E),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              Text(
                LocaleKeys.anfari.tr(),
                style: context.textTheme.headline1,
              ),
              const Spacer(),
              Text(
                LocaleKeys.etudiant.tr(),
                style: context.textTheme.headline2,
              ),
              70.h.heightBox,
            ],
          ),
        ),
      ),
    );
  }
}
