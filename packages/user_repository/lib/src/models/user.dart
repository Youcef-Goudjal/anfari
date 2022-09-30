import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

/// {@template user}
/// User model
///
/// [User.empty] represents an unauthenticated user.
/// {@endtemplate}
class User extends Equatable {
  /// {@macro user}
  const User({
    required this.id,
    this.email,
    this.name,
    this.firstName,
    this.lastName,
    this.photo,
    this.phoneNumber,
    this.photoResized,
    this.photoThumbail,
  });

  /// The current user's email address.
  final String? email;

  /// The current user's id.
  final String id;

  /// The current user's name (display name).
  final String? name;

  /// full name
  final String? firstName;
  final String? lastName;

  /// Url for the current user's photo.
  final String? photo;

  /// The current user's phone number
  final String? phoneNumber;

  ///500*500 version of [photo]
  final String? photoResized;

  /// small version of [photo]
  final String? photoThumbail;

  /// Empty user which represents an unauthenticated user.
  static const empty = User(id: '');

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == User.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != User.empty;

  @override
  List<Object?> get props => [email, id, name, photo];

  static User fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    if (snapshot.exists) {
      final data = snapshot.data()!;
      return User(
        id: data["uid"],
        name: data["name"],
        email: data["email"],
        phoneNumber: data["phoneNumber"],
        photo: data["photo"],
        firstName: data["firstName"],
        lastName: data["lastName"],
        photoResized: data["photoResized"],
        photoThumbail: data["photoThumbail"],
      );
    }
    return User.empty;
  }

  static User fromMap(Map<String, dynamic>? data) {
    if (data == null) {
      return User.empty;
    } else {
      return User(
        id: data["uid"],
        name: data["name"],
        email: data["email"],
        phoneNumber: data["phoneNumber"],
        photo: data["photo"],
        firstName: data["firstName"],
        lastName: data["lastName"],
        photoResized: data["photoResized"],
        photoThumbail: data["photoThumbail"],
      );
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "uid": id,
      "name": name,
      "email": email,
      "phoneNumber": phoneNumber,
      "photo": photo,
      "firstName": firstName,
      "lastName": lastName,
      "photoResized": photoResized,
      "photoThumbail": photoThumbail,
    };
  }

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? photo,
    String? phoneNumber,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      photo: photo ?? this.photo,
    );
  }
}
