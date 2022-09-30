import 'package:anfari/core/extensions/extensions.dart';
import 'package:anfari/core/widgets/widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:posts_repository/posts_repository.dart';
import 'package:user_repository/user_repository.dart';

class PostCard extends StatelessWidget {
  final Post post;
  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// header section of the post
        _HeaderPost(
          user: post.owner,
          createdAt: post.createdAt,
        ),

        /// image section
        const _ImagePost(),

        /// Likes , comment of the post
        const _LikesCommentPost(),

        /// Description section
        const _DescriptionPost()
      ],
    );
  }
}

class _DescriptionPost extends StatelessWidget {
  const _DescriptionPost({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class _LikesCommentPost extends StatelessWidget {
  const _LikesCommentPost({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class _ImagePost extends StatelessWidget {
  const _ImagePost({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class _HeaderPost extends StatelessWidget {
  final User user;
  final DateTime createdAt;
  const _HeaderPost({
    Key? key,
    required this.user,
    required this.createdAt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 4.h,
        horizontal: 16.w,
      ).copyWith(right: 0),
      child: Row(
        children: [
          17.w.widthBox,
          Avatar.medium(user: user),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 18.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.UserName ?? "username",
                    style: context.textTheme.headline4!.copyWith(
                      fontSize: 14.sp,
                    ),
                  ),
                  Text(
                    DateFormat.MMMd(context.locale.languageCode)
                        .format(createdAt),
                    style: context.textTheme.headline5!.copyWith(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xff848484).withOpacity(0.8),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
