import 'package:anfari/core/extensions/extensions.dart';
import 'package:anfari/core/manager/language/locale_keys.g.dart';
import 'package:anfari/core/manager/route/router.dart';
import 'package:anfari/product/constants/asset_constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BoardingPage extends StatefulWidget {
  static Page<void> page() => const MaterialPage(child: BoardingPage());

  const BoardingPage({super.key});

  @override
  State<BoardingPage> createState() => _BoardingPageState();
}

class _BoardingPageState extends State<BoardingPage> {
  late ImageProvider boarding1, boarding2, boarding3;
  @override
  void initState() {
    super.initState();
    boarding1 = const AssetImage(AppAssets.boarding1);
    boarding2 = const AssetImage(AppAssets.boarding2);
    boarding3 = const AssetImage(AppAssets.boarding3);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    precacheImage(boarding1, context);
    precacheImage(boarding2, context);
    precacheImage(boarding3, context);
  }

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView(
          controller: _pageController,
          children: [
            BoardingOne(
              image: boarding1,
              function: () {
                _pageController.animateToPage(
                  1,
                  duration: 400.milliseconds,
                  curve: Curves.easeInOut,
                );
              },
            ),
            BoardingTwo(
              image: boarding2,
              function: () {
                _pageController.animateToPage(
                  2,
                  duration: 400.milliseconds,
                  curve: Curves.easeInOut,
                );
              },
            ),
            BoardingThree(
              image: boarding3,
            ),
          ],
        ),
      ],
    );
  }
}

class BoardingOne extends StatelessWidget {
  final Function function;
  final ImageProvider image;
  const BoardingOne({super.key, required this.function, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 52.w),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: image,
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.67),
            BlendMode.colorBurn,
          ),
        ),
      ),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            260.h.heightBox,
            SvgPicture.asset(
              AppAssets.bookLogo,
              height: 88.h,
              width: 102.w,
            ),
            66.h.heightBox,
            Text(
              LocaleKeys.anfari.tr(),
              style: context.textTheme.headline1!.copyWith(
                fontWeight: FontWeight.normal,
              ),
            ),
            16.h.heightBox,
            Text(
              LocaleKeys.boarding1_description.tr(),
              style: context.textTheme.headline1!.copyWith(
                fontWeight: FontWeight.normal,
              ),
            ),
            93.h.heightBox,
            Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                height: 60.h,
                width: 105.w,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: 21.w,
                      vertical: 17.h,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  onPressed: () {
                    function.call();
                  },
                  child: Text(
                    LocaleKeys.boarding_nextBtn.tr(),
                    style: context.textTheme.headline3,
                  ),
                ),
              ),
            ),
            240.h.heightBox,
          ],
        ),
      ),
    );
  }
}

class BoardingTwo extends StatelessWidget {
  final ImageProvider image;
  final Function function;
  const BoardingTwo({super.key, required this.function, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 52.w),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: image,
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.67),
            BlendMode.colorBurn,
          ),
        ),
      ),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            260.h.heightBox,
            SvgPicture.asset(
              AppAssets.bookLogo,
              height: 88.h,
              width: 102.w,
            ),
            66.h.heightBox,
            Text(
              LocaleKeys.anfari.tr(),
              style: context.textTheme.headline1!.copyWith(
                fontWeight: FontWeight.normal,
              ),
            ),
            16.h.heightBox,
            Text(
              LocaleKeys.boarding2_description.tr(),
              style: context.textTheme.headline2!.copyWith(
                fontWeight: FontWeight.normal,
              ),
              textAlign: TextAlign.center,
            ),
            73.h.heightBox,
            Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                height: 60.h,
                width: 105.w,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: 21.w,
                      vertical: 17.h,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  onPressed: () {
                    function.call();
                  },
                  child: Text(
                    LocaleKeys.boarding_nextBtn.tr(),
                    style: context.textTheme.headline3,
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

class BoardingThree extends StatelessWidget {
  final ImageProvider image;
  const BoardingThree({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 52.w),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: image,
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.67),
            BlendMode.colorBurn,
          ),
        ),
      ),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            72.h.heightBox,
            SvgPicture.asset(
              AppAssets.bookLogo,
              height: 88.h,
              width: 102.w,
            ),
            41.h.heightBox,
            Text(
              LocaleKeys.anfari.tr(),
              style: context.textTheme.headline1!.copyWith(
                fontWeight: FontWeight.normal,
              ),
            ),
            370.h.heightBox,
            SizedBox(
              height: 60.h,
              width: 350.w,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: 21.w,
                    vertical: 17.h,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                onPressed: () {},
                child: Row(
                  children: [
                    Text(
                      LocaleKeys.boarding3_discoverBtn.tr(),
                      style: context.textTheme.headline3,
                    ),
                    const Spacer(),
                    FaIcon(
                      FontAwesomeIcons.circleArrowLeft,
                      color: Colors.white,
                      size: 20.w,
                    )
                  ],
                ),
              ),
            ),
            22.h.heightBox,
            SizedBox(
              height: 60.h,
              width: 350.w,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: 21.w,
                    vertical: 17.h,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, AppRouter.login);
                },
                child: Row(
                  children: [
                    Text(
                      LocaleKeys.boarding3_LoginBtn.tr(),
                      style: context.textTheme.headline3,
                    ),
                    const Spacer(),
                    FaIcon(
                      FontAwesomeIcons.circleArrowLeft,
                      color: Colors.white,
                      size: 20.w,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
