import 'package:anfari/core/extensions/extensions.dart';
import 'package:anfari/core/manager/language/locale_keys.g.dart';
import 'package:anfari/core/manager/route/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../login.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        //TODO:
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 43.w,
          vertical: 55.h,
        ),
        child: SingleChildScrollView(
          child: Center(
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
                52.h.heightBox,
                SizedBox(
                  height: 100.h,
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              vertical: 13.h,
                              horizontal: 21.w,
                            ),
                          ),
                          child: Center(
                            child: Row(
                              children: [
                                Text(
                                  LocaleKeys.login_userBtn.tr(),
                                  style: context.textTheme.headline2!.copyWith(
                                    color: Colors.black,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                                const Spacer(),
                                FaIcon(
                                  FontAwesomeIcons.circleCheck,
                                  size: 26.w,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      17.w.widthBox,
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              vertical: 13.h,
                              horizontal: 21.w,
                            ),
                          ),
                          child: Center(
                            child: Row(
                              children: [
                                Text(
                                  LocaleKeys.login_developerBtn.tr(),
                                  style: context.textTheme.headline2!.copyWith(
                                    color: Colors.black,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                                const Spacer(),
                                FaIcon(
                                  FontAwesomeIcons.circleCheck,
                                  size: 26.w,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                52.h.heightBox,
                Text(
                  LocaleKeys.login_text.tr(),
                  style: context.textTheme.headline4,
                ),
                18.h.heightBox,
                Text(
                  LocaleKeys.login_textDescription.tr(),
                  style: context.textTheme.headline5,
                ),
                73.h.heightBox,
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    LocaleKeys.login_enterPhone.tr(),
                    style: context.textTheme.headline4!.copyWith(
                      fontSize: 14,
                    ),
                  ),
                ),
                16.h.heightBox,
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: SizedBox(
                    height: 61.h,
                    child: TextField(
                      style: context.textTheme.headline4!.copyWith(
                        fontSize: 20,
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 23.w,
                          vertical: 15.h,
                        ),
                        prefixText: "+213",
                      ),
                    ),
                  ),
                ),
                32.h.heightBox,
                SizedBox(
                  height: 60.h,
                  child: ElevatedButton(
                    onPressed: () {
                      context.router.push(const OtpRoute());
                    },
                    child: Center(
                      child: Text(
                        LocaleKeys.login_sendBtn.tr(),
                        style: context.textTheme.headline2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
