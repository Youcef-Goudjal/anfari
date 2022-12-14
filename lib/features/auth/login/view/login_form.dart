import 'package:anfari/core/extensions/extensions.dart';
import 'package:anfari/core/manager/language/locale_keys.g.dart';
import 'package:anfari/core/manager/theme/theme_manager.dart';
import 'package:anfari/features/auth/login/bloc/phone_auth_bloc.dart';
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
                const _BackBtn(),
                52.h.heightBox,
                SizedBox(
                  height: 100.h,
                  child: Row(
                    children: [
                      const _UserBtn(),
                      17.w.widthBox,
                      const _DeveloperBtn(),
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
                const _PhoneInput(),
                32.h.heightBox,
                const _SendBtn(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BackBtn extends StatelessWidget {
  const _BackBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const FaIcon(
          FontAwesomeIcons.chevronRight,
          size: 29,
          color: Colors.black,
        ),
      ),
    );
  }
}

class _UserBtn extends StatelessWidget {
  const _UserBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) =>
          previous.isDeveloper != current.isDeveloper,
      builder: (context, state) {
        return KLoginBtn(
          onPressed: context.read<LoginCubit>().isUserTapped,
          title: LocaleKeys.login_userBtn.tr(),
          isActive: !state.isDeveloper,
        );
      },
    );
  }
}

class _DeveloperBtn extends StatelessWidget {
  const _DeveloperBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) =>
          previous.isDeveloper != current.isDeveloper,
      builder: (context, state) {
        return KLoginBtn(
          onPressed: context.read<LoginCubit>().isDeveloperTapped,
          title: LocaleKeys.login_developerBtn.tr(),
          isActive: state.isDeveloper,
        );
      },
    );
  }
}

class KLoginBtn extends StatelessWidget {
  final void Function()? onPressed;
  final bool isActive;
  final String title;
  final IconData? icon;
  const KLoginBtn({
    super.key,
    required this.onPressed,
    this.isActive = false,
    required this.title,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              isActive ? ThemeManager.primaryColor : const Color(0xffEFEFEF),
          padding: EdgeInsets.symmetric(
            vertical: 13.h,
            horizontal: 21.w,
          ),
        ),
        child: Center(
          child: Row(
            children: [
              Text(
                title,
                style: context.textTheme.headline2!.copyWith(
                  color: Colors.black,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.right,
              ),
              const Spacer(),
              FaIcon(
                isActive
                    ? FontAwesomeIcons.circleCheck
                    : FontAwesomeIcons.circle,
                size: 26.w,
                color: isActive ? Colors.white : Colors.black,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _SendBtn extends StatelessWidget {
  const _SendBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.h,
      child: ElevatedButton(
        onPressed: () {
          final phoneNumber = context.read<LoginCubit>().state.phone.value;
          context
              .read<PhoneAuthBloc>()
              .add(SendOtpToPhoneEvent(phoneNumber: phoneNumber));
        },
        child: Center(
          child: Text(
            LocaleKeys.login_sendBtn.tr(),
            style: context.textTheme.headline2,
          ),
        ),
      ),
    );
  }
}

class _PhoneInput extends StatelessWidget {
  const _PhoneInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: BlocBuilder<LoginCubit, LoginState>(
        buildWhen: (previous, current) => previous.phone != current.phone,
        builder: (context, state) {
          return TextField(
            style: context.textTheme.headline4!.copyWith(
              fontSize: 20,
            ),
            onChanged: (phone) =>
                context.read<LoginCubit>().phoneChanged(phone),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 23.w,
                vertical: 15.h,
              ),
              prefixText: "+213",
              errorText: state.phone.invalid ? "invalid phone number" : null,
            ),
          );
        },
      ),
    );
  }
}
