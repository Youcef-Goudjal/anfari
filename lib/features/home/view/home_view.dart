import 'package:anfari/core/extensions/extensions.dart';
import 'package:anfari/core/manager/route/router.dart';
import 'package:anfari/core/manager/theme/theme_manager.dart';
import 'package:anfari/core/widgets/avatars.dart';
import 'package:anfari/features/university/views/views.dart';
import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/bloc/bloc.dart';
import '../../../core/manager/language/locale_keys.g.dart';
import '../../posts/posts.dart';

class HomePage extends StatelessWidget {
  static Page<void> page() => const MaterialPage(child: HomePage());

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileNotRegistred) {
          Navigator.pushNamed(context, AppRouter.register);
        } else if (state is ProfileLoaded) {
          if (state.loggedUser.isDeveloper) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRouter.developer,
              (route) => false,
            );
          }
        }
      },
      child: const Scaffold(
        backgroundColor: Colors.white,
        body: _HomeBody(),
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
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverAppBar(
            pinned: true,
            title: Text(
              LocaleKeys.anfari.tr(),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
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
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const _ProfileHeader(),
                _SearchBar(),
                20.h.heightBox,
                const UniversitiesList(),
              ],
            ),
          )
        ];
      },
      body: Center(
        child: Column(
          children: [
            20.h.heightBox,
            const Expanded(
              child: PostsWidget(),
            ),
          ],
        ),
      ),
    );
  }
}



class _SearchBar extends StatelessWidget {
  final textController = TextEditingController();
  _SearchBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 30.w, left: 35.w),
      child: AnimSearchBar(
        width: context.width,
        textController: textController,
        onSuffixTap: () {
          textController.clear();
        },
        color: ThemeManager.primaryColor,
        suffixIcon: const Icon(
          Icons.arrow_back_ios_rounded,
          color: Colors.white,
        ),
        prefixIcon: const Icon(
          Icons.search,
          color: Colors.white,
        ),
        helpText: "  ??????  ",
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return SizedBox(
          height: 80.h,
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 17.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  (state is ProfileLoaded)
                      ? Avatar.medium(
                          user: context.read<ProfileBloc>().loggedUser,
                        )
                      : SizedBox(
                          height: 61.w,
                          width: 61.w,
                          child: const CircularProgressIndicator(),
                        ),
                  16.w.widthBox,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        LocaleKeys.home_welcome.tr(
                          namedArgs: {
                            "name": context
                                    .read<ProfileBloc>()
                                    .loggedUser
                                    .UserName ??
                                "username",
                          },
                        ),
                        style: context.textTheme.headline3!
                            .copyWith(fontSize: 29.sp, color: Colors.black),
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
          ),
        );
      },
    );
  }
}
