import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:user_repository/user_repository.dart';

class FirebaseUserRepository implements UserRepository {
  final _userCollection = FirebaseFirestore.instance.collection("users");

  /// add new doc to users collection
  /// [newUser] is data of new user
  @override
  Future<void> addUserData(User newUser) async {
    return await _userCollection.doc(newUser.id).set(newUser.toJson());
  }

  /// Get user by id
  /// [uid] is the user id from firebase auth
  @override
  Future<User> getUserById(String uid) async {
    return await _userCollection
        .doc(uid)
        .get()
        .then((doc) => User.fromSnapshot(doc));
  }

  /// Stream of logged user
  /// [loggedUser] is user of firebase Auth
  @override
  Stream<User> loggedUserStream(User loggedUser) {
    return _userCollection
        .doc(loggedUser.id)
        .snapshots()
        .map((doc) => User.fromSnapshot(doc));
  }

  /// Update a doc in users collection
  /// [updatedUser] is updated data of user
  @override
  Future<void> updateUserData(
    User updatedUser, {
    Map<String, dynamic>? additionalData,
  }) async {
    await _userCollection.doc(updatedUser.id).get().then(
      (doc) async {
        Map<String, dynamic> data = updatedUser.toJson();

        if (additionalData != null) data.addAll(additionalData);
        if (doc.exists) {
          // update
          await doc.reference.update(data);
        } else {
          await doc.reference.set(data);
        }
      },
    );
  }
}
