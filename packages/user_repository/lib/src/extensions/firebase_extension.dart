import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:user_repository/user_repository.dart';

extension on firebase_auth.User {
  User get toUser {
    return User(
      id: uid,
      email: email,
      name: displayName,
      photo: photoURL,
      phoneNumber: phoneNumber,
    );
  }
}
