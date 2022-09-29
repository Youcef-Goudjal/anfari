import 'package:anfari/core/extensions/extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/manager/language/locale_keys.g.dart';

class RegisterPage extends StatelessWidget {
  static Page<void> page() => const MaterialPage(child: RegisterPage());

  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: RegisterForm(),
    );
  }
}

class RegisterForm extends StatelessWidget {
  const RegisterForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 43.w,
        vertical: 55.h,
      ),
      child: Center(
        child: Column(
          children: [
            24.h.heightBox,
            Text(
              LocaleKeys.register_title.tr(),
              style: context.textTheme.headline1!.copyWith(
                color: Colors.black,
              ),
            ),
            28.h.heightBox,
            SizedBox(
              height: 175.h,
              width: 175.w,
              child: Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 100,
                      backgroundColor: const Color(0xffF5F5F5),
                      child: FaIcon(
                        FontAwesomeIcons.solidUser,
                        color: const Color(0xff666666).withOpacity(0.2),
                        size: 134.h,
                      ),
                    ),
                    Positioned(
                      bottom: 12.h,
                      right: 22.w,
                      child: Container(
                        height: 17.h,
                        width: 17.w,
                        decoration: BoxDecoration(
                          color: context.theme.primaryColor,
                          borderRadius: BorderRadius.circular(2.r),
                        ),
                        child: Center(
                          child: FaIcon(
                            FontAwesomeIcons.pen,
                            color: Colors.white,
                            size: 9.w,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            34.h.heightBox,
            SizedBox(
              height: 55.h,
              child: TextField(
                decoration: InputDecoration(
                  hintText: LocaleKeys.register_username.tr(),
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(top: 10.h, right: 10.w),
                    child: const FaIcon(
                      FontAwesomeIcons.user,
                    ),
                  ),
                ),
              ),
            ),
            26.h.heightBox,
            SizedBox(
              height: 55.h,
              child: TextField(
                decoration: InputDecoration(
                  hintText: LocaleKeys.register_fac.tr(),
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(top: 10.h, right: 10.w),
                    child: const FaIcon(
                      FontAwesomeIcons.user,
                    ),
                  ),
                ),
              ),
            ),
            26.h.heightBox,
            SizedBox(
              height: 55.h,
              child: TextField(
                decoration: InputDecoration(
                  hintText: LocaleKeys.register_faculty.tr(),
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(top: 10.h, right: 10.w),
                    child: const FaIcon(
                      FontAwesomeIcons.user,
                    ),
                  ),
                ),
              ),
            ),
            26.h.heightBox,
            SizedBox(
              height: 55.h,
              child: TextField(
                decoration: InputDecoration(
                  hintText: LocaleKeys.register_special.tr(),
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(top: 10.h, right: 10.w),
                    child: const FaIcon(
                      FontAwesomeIcons.user,
                    ),
                  ),
                ),
              ),
            ),
            32.h.heightBox,
            SizedBox(
              height: 60.h,
              child: ElevatedButton(
                onPressed: () {
                  //TODO: save data
                },
                child: Center(
                  child: Text(
                    LocaleKeys.register_save.tr(),
                    style: context.textTheme.headline2,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
