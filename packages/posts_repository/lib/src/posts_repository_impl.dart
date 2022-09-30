import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:posts_repository/posts_repository.dart';

class PostsRepositoryImpl implements PostRepository {
  final db = FirebaseFirestore.instance;
  late final _postsCollection = db.collection("posts");

  PostsRepositoryImpl() {
    db.settings = Settings(
      //cacheSizeBytes:  ,
      persistenceEnabled: true,
    );
  }
  @override
  Future<void> addNewPost(Post newPost) async {
    return await _postsCollection.doc(newPost.uid).set(newPost.toJson());
  }

  @override
  Future<Post> getPostById(String uid) async {
    return await _postsCollection
        .doc(uid)
        .get()
        .then((doc) => Post.fromMap(doc.data()));
  }

  @override
  Stream<List<Post>> postsListStream() {
    return _postsCollection.snapshots().map(
          (event) => event.docs
              .map(
                (e) => Post.fromMap(
                  e.data(),
                ),
              )
              .toList(),
        );
  }

  @override
  Future<List<Post>> fetchPosts({String? startAtUid, int limit = 10}) async {
    if (startAtUid == null) {
      return await _postsCollection
          .orderBy("createdAt", descending: true)
          .limit(limit)
          .get()
          .then(
            (doc) => doc.docs
                .map(
                  (e) => Post.fromMap(e.data()),
                )
                .toList(),
          );
    } else {
      return await _postsCollection
          .orderBy("createdAt", descending: true)
          .startAfter([startAtUid])
          .limit(limit)
          .get()
          .then(
            (doc) => doc.docs
                .map(
                  (e) => Post.fromMap(e.data()),
                )
                .toList(),
          );
    }
  }
}
