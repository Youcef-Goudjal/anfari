import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_repository/posts_repository.dart';
import 'package:stream_transform/stream_transform.dart';

part 'post_event.dart';
part 'post_state.dart';

const _postLimit = 10;
const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository _postRepository;
  PostBloc(this._postRepository) : super(const PostState()) {
    on<PostFetched>(_onPostFetched,
        transformer: throttleDroppable(throttleDuration));
  }

  Future<void> _onPostFetched(
      PostFetched event, Emitter<PostState> emit) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == PostStatus.initial) {
        final posts = await _postRepository.fetchPosts();
        bool hasReachedMax = (posts.length) % _postLimit != 0;
        return emit(state.copyWith(
          status: PostStatus.success,
          posts: posts,
          hasReachedMax: hasReachedMax,
        ));
      }
      final posts =
          await _postRepository.fetchPosts
          (startAtUid: state.posts.last.uid);
      bool hasReachedMax = (posts.length) % _postLimit == 0;
      posts.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(
              state.copyWith(
                status: PostStatus.success,
                posts: List.of(state.posts)..addAll(posts),
                hasReachedMax: hasReachedMax,
              ),
            );
    } catch (e) {
      emit(state.copyWith(status: PostStatus.failure));
    }
  }
}
