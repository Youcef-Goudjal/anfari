import 'package:anfari/core/extensions/extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/manager/language/locale_keys.g.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
