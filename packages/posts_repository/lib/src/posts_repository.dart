import 'package:posts_repository/posts_repository.dart';

abstract class PostRepository {
  /// Stream of posts
  /// from cloud firestore
  Stream<List<Post>> postsListStream();

  /// Get post By Id
  /// [uid] is the post id
  Future<Post> getPostById(String uid);

  /// add new doc to posts collection
  /// [newPost] is data of new post
  Future<void> addNewPost(Post newPost);

  /// fetch posts once
  Future<List<Post>> fetchPosts({String? startAtUid});
}
