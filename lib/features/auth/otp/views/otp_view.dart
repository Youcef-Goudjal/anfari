import 'package:anfari/core/extensions/extensions.dart';
import 'package:anfari/core/manager/route/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/manager/language/locale_keys.g.dart';

class OtpView extends StatelessWidget {
  const OtpView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: OtpForm(),
    );
  }
}

class OtpForm extends StatelessWidget {
  const OtpForm({
    Key? key,
  }) : super(key: key);

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
            SizedBox(
              height: 60.h,
              child: Row(),
            ),
            32.h.heightBox,
            SizedBox(
              height: 60.h,
              child: ElevatedButton(
                onPressed: () {
                  context.router.push(const RegisterRoute());
                },
                child: Center(
                  child: Text(
                    LocaleKeys.otp_verifyBtn.tr(),
                    style: context.textTheme.headline2,
                  ),
                ),
              ),
            ),
            16.h.heightBox,
            Row(
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
            )
          ],
        ),
      ),
    );
  }
}
