import 'package:anfari/core/extensions/extensions.dart';
import 'package:anfari/core/manager/route/router.dart';
import 'package:anfari/core/manager/theme/theme_manager.dart';
import 'package:anim_search_bar/anim_search_bar.dart';
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
        backgroundColor: Colors.white,
        appBar: AppBar(
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
        body: const SingleChildScrollView(
          child: _HomeBody(),
        ),
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
          const _ProfileHeader(),
          _SearchBar(),
          20.h.heightBox,
          const _UniversityList(),
        ],
      ),
    );
  }
}

class _UniversityList extends StatelessWidget {
  const _UniversityList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180.h,
      child: ListView.separated(
        padding: EdgeInsets.only(right: 17.w),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 50.w,
                width: 50.w,
                decoration: BoxDecoration(
                  color: ThemeManager.primaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            );
          } else {
            return SizedBox(
              width: 125.w,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffD0EBE5).withOpacity(0.5),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Align(
                        alignment: Alignment.centerRight,
                        child: Icon(Icons.exit_to_app),
                      ),
                      6.h.heightBox,
                      Text(
                        "جامعة بشار",
                        style: context.textTheme.headline4!.copyWith(
                          fontSize: 18.sp,
                        ),
                      ),
                      18.h.heightBox,
                      Text(
                        "1275 موضوع مع حله",
                        style: context.textTheme.headline5!.copyWith(
                          fontSize: 14.sp,
                          color: Colors.black45,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }
        },
        separatorBuilder: (context, index) {
          return SizedBox(
            width: 20.w,
          );
        },
        itemCount: 10,
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
        helpText: "  بحث  ",
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
                      ? Stack(
                          children: [
                            Container(
                              height: 61.w,
                              width: 61.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: NetworkImage(
                                    context
                                        .read<ProfileBloc>()
                                        .loggedUser
                                        .photo!,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 2.w,
                              bottom: 8.h,
                              child: Container(
                                height: 11.w,
                                width: 11.w,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: ThemeManager.primaryColor,
                                ),
                              ),
                            )
                          ],
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
                            "name":
                                context.read<ProfileBloc>().loggedUser.name ??
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
