import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Post extends Equatable {
  final String uid;
  final String description;
  final String username;
  final likes;
  final String postId;
  final DateTime datePublished;
  final String postUrl;
  final String profImage;

  const Post({
    required this.uid,
    required this.description,
    required this.username,
    required this.likes,
    required this.postId,
    required this.datePublished,
    required this.postUrl,
    required this.profImage,
  });

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Post(
      uid: snapshot[" uid"],
      description: snapshot[" description"],
      username: snapshot[" username"],
      likes: snapshot[" likes"],
      postId: snapshot[" postId"],
      datePublished: snapshot[" datePublished"],
      postUrl: snapshot[" postUrl"],
      profImage: snapshot[" profImage"],
    );
  }

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "description": description,
        "username": username,
        "likes": likes,
        "postId": postId,
        "datePublished": datePublished,
        "postUrl": postUrl,
        "profImage": profImage,
      };

  @override
  List<Object?> get props => [
        uid,
        description,
        username,
        likes,
        postId,
        datePublished,
        postUrl,
        profImage,
      ];
}
