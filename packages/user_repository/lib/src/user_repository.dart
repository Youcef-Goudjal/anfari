import 'package:user_repository/user_repository.dart';

abstract class UserRepository {
  /// Stream of logged user
  /// [loggedUser] is user of firebase Auth
  ///
  Stream<User> loggedUserStream(User loggedUser);

  /// Get user by id
  /// [uid] is the user id from firebase auth
  ///
  Future<User> getUserById(String uid);

  /// add new doc to users collection
  /// [newUser] is data of new user
  Future<void> addUserData(User newUser);

  /// Update a doc in users collection
  /// [updatedUser] is updated data of user
  Future<void> updateUserData(User updatedUser);
}
