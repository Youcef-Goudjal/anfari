import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

class Post extends Equatable {
  final String uid;
  final User owner;
  final List<String> likes;
  final String imageUrl;
  final String Description;
  final DateTime createdAt;

  Post({
    required this.uid,
    required this.owner,
    List<String>? likes,
    required this.Description,
    required this.imageUrl,
    DateTime? createdAt,
  })  : this.createdAt = createdAt ?? DateTime.now(),
        this.likes = likes ?? [];

  @override
  List<Object?> get props => [uid, owner, likes, Description, imageUrl];

  /// empty post which represent the post when created
  static final empty = Post(
    uid: "",
    Description: "",
    owner: User.empty,
    likes: [],
    imageUrl: "",
  );

  /// Convenience getter to determine whether the current post is empty.
  bool get isEmpty => this == Post.empty;

  /// Convenience getter to determine whether the current post is not empty.
  bool get isNotEmpty => this != Post.empty;

  static Post fromMap(Map<String, dynamic>? data) {
    if (data == null) {
      return Post.empty;
    } else {
      return Post(
        uid: data["uid"],
        owner: User.fromMap(data["owner"]),
        likes:
            (data["likes"] as List<dynamic>).map((e) => e.toString()).toList(),
        Description: data["Description"],
        imageUrl: data["imageUrl"],
        createdAt: (data["createdAt"]as Timestamp).toDate(),
      );
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "uid": this.uid,
      "owner": this.owner.toJson(),
      "likes": this.likes,
      "Description": this.Description,
      "imageUrl": this.imageUrl,
      "createdAt": this.createdAt,
    };
  }
}
