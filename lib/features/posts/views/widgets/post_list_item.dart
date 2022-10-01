import 'package:anfari/core/bloc/profile/profile_bloc.dart';
import 'package:anfari/core/extensions/extensions.dart';
import 'package:anfari/core/manager/theme/theme_manager.dart';
import 'package:anfari/core/widgets/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        _ImagePost(
          imageUrl: post.imageUrl,
        ),

        /// Likes , comment of the post
        _LikesCommentPost(
          likes: post.likes,
        ),

        /// Description section
        _DescriptionPost(
          description: post.Description,
        )
      ],
    );
  }
}

class _DescriptionPost extends StatelessWidget {
  final String description;
  const _DescriptionPost({
    Key? key,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: 8.h,
        right: 27.w,
      ),
      child: Text(
        description,
        style: context.textTheme.headline1!.copyWith(
          fontSize: 12.sp,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}

class _LikesCommentPost extends StatefulWidget {
  final List<String> likes;
  const _LikesCommentPost({
    Key? key,
    required this.likes,
  }) : super(key: key);

  @override
  State<_LikesCommentPost> createState() => _LikesCommentPostState();
}

class _LikesCommentPostState extends State<_LikesCommentPost> {
  @override
  Widget build(BuildContext context) {
    final uid = context.read<ProfileBloc>().loggedUser.id;
    return Row(
      children: [
        LikeAnimation(
          isAnimating: widget.likes.contains(uid),
          child: IconButton(
            icon: widget.likes.contains(uid)
                ? const Icon(
                    Icons.favorite,
                    color: ThemeManager.primaryColor,
                  )
                : const Icon(
                    Icons.favorite_border,
                    color: ThemeManager.primaryColor,
                  ),
            onPressed: () {
              if (widget.likes.contains(uid)) {
                widget.likes.remove(uid);
              } else {
                widget.likes.add(uid);
              }
              setState(() {});
              // TODO: like post
            },
          ),
        ),
        const Spacer(),
        IconButton(
          onPressed: () {
            // TODO: go to comment screen
          },
          icon: const Icon(
            Icons.comment_outlined,
            color: ThemeManager.primaryColor,
          ),
        )
      ],
    );
  }
}

class _ImagePost extends StatefulWidget {
  final String imageUrl;

  const _ImagePost({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  @override
  State<_ImagePost> createState() => _ImagePostState();
}

class _ImagePostState extends State<_ImagePost> {
  bool isLikeAnimating = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {},
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            height: context.height * 0.5,
            width: double.infinity,
            child: CachedNetworkImage(
              imageUrl: widget.imageUrl,
              fit: BoxFit.contain,
              imageBuilder: (context, imageProvider) {
                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),
          AnimatedOpacity(
            opacity: isLikeAnimating ? 1 : 0,
            duration: 200.milliseconds,
            child: LikeAnimation(
              isAnimating: isLikeAnimating,
              duration: 400.milliseconds,
              onEnd: () {
                setState(() {
                  isLikeAnimating = false;
                });
              },
              child: const Icon(
                Icons.favorite,
                color: Colors.white,
                size: 100,
              ),
            ),
          )
        ],
      ),
    );
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
