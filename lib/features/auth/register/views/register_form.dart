import 'package:anfari/core/extensions/extensions.dart';
import 'package:anfari/features/auth/register/cubit/register_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/manager/language/locale_keys.g.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
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
              const AvatarWidget(),
              34.h.heightBox,
              const _UsernameField(),
              26.h.heightBox,
              const _UniversityField(),
              26.h.heightBox,
              const _FacultyField(),
              26.h.heightBox,
              const _SpecialityField(),
              32.h.heightBox,
              const _SaveBtn(),
            ],
          ),
        ),
      ),
    );
  }
}

class _SaveBtn extends StatelessWidget {
  const _SaveBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
    );
  }
}

class KTextField extends StatelessWidget {
  final String title;
  final IconData icon;
  final void Function(String value)? onChanged;
  const KTextField({
    super.key,
    required this.title,
    required this.icon,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: title,
        prefixIcon: Padding(
          padding: EdgeInsets.only(top: 22.h, right: 20.w),
          child: FaIcon(icon),
        ),
      ),
    );
  }
}

class _SpecialityField extends StatelessWidget {
  const _SpecialityField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      buildWhen: (previous, current) =>
          previous.speciality != current.speciality,
      builder: (context, state) {
        return KTextField(
          title: LocaleKeys.register_special.tr(),
          icon: FontAwesomeIcons.wandSparkles,
          onChanged: context.read<RegisterCubit>().specialityChanged,
        );
      },
    );
  }
}

class _FacultyField extends StatelessWidget {
  const _FacultyField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      buildWhen: (previous, current) => previous.faculty != current.faculty,
      builder: (context, state) {
        return KTextField(
          title: LocaleKeys.register_faculty.tr(),
          icon: FontAwesomeIcons.building,
          onChanged: context.read<RegisterCubit>().facultyChanged,
        );
      },
    );
  }
}

class _UniversityField extends StatelessWidget {
  const _UniversityField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      buildWhen: (previous, current) =>
          previous.university != current.university,
      builder: (context, state) {
        return KTextField(
          title: LocaleKeys.register_fac.tr(),
          icon: FontAwesomeIcons.buildingColumns,
          onChanged: context.read<RegisterCubit>().universityChanged,
        );
      },
    );
  }
}

class _UsernameField extends StatelessWidget {
  const _UsernameField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return KTextField(
          title: LocaleKeys.register_special.tr(),
          icon: FontAwesomeIcons.user,
          onChanged: context.read<RegisterCubit>().usernameChanged,
        );
      },
    );
  }
}

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 175.h,
      width: 175.w,
      child: BlocBuilder<RegisterCubit, RegisterState>(
        /// build when the image changed from file or from url
        buildWhen: (previous, current) =>
            (previous.imageUrl != current.imageUrl) |
            (previous.file != current.file),
        builder: (context, state) {
          return GestureDetector(
            onTap: context.read<RegisterCubit>().pickImage,
            child: Center(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      // border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: CircleAvatar(
                      radius: 199.w,
                      backgroundColor: const Color(0xffF5F5F5),
                      child: (state.imageUrl.isNotEmpty)
                          ? Image.network(state.imageUrl)
                          : (state.file != null)
                              ? Image.file(state.file!)
                              : FaIcon(
                                  Icons.person,
                                  size: 170.h,
                                  color:
                                      const Color(0xff666666).withOpacity(0.2),
                                ),
                    ),
                  ),
                  Positioned(
                    bottom: 12.h,
                    right: 22.w,
                    child: Container(
                      height: 17.h,
                      width: 17.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2.r),
                        color: context.theme.primaryColor,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 11.h,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
