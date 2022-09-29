import 'package:anfari/core/extensions/extensions.dart';
import 'package:anfari/core/manager/route/router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
            const Align(
              alignment: Alignment.center,
              child: FaIcon(
                FontAwesomeIcons.message,
                color: Colors.black,
              ),
            ),
            13.w.widthBox,
            const Align(
              alignment: Alignment.center,
              child: FaIcon(
                FontAwesomeIcons.bell,
                color: Colors.black,
              ),
            ),
            15.w.widthBox,
          ],
        ),
        body: const _HomeBody(),
      ),
    );
  }
}

class _HomeBody extends StatelessWidget {
  const _HomeBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 60.h,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 61.w,
                    width: 61.w,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage(
                          context.read<ProfileBloc>().loggedUser.photo!,
                        ))),
                  ),
                  Column(
                    children: [
                      Text(
                        LocaleKeys.home_welcome.tr(
                          namedArgs: {
                            "name":
                                context.read<ProfileBloc>().loggedUser.name ??
                                    "username",
                          },
                        ),
                        style: context.textTheme.headline3!.copyWith(
                          fontSize: 29.sp,
                        ),
                      ),
                      Text(
                        "+25",
                        style: context.textTheme.headline5,
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
