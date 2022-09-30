import 'package:authentication_repository/authentication_repository.dart';
import 'package:cache/cache.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:user_repository/user_repository.dart';

/// Repository which manages user authentication
class AuthenticationRepository {
  AuthenticationRepository({
    CacheClient? cacheClient,
    firebase_auth.FirebaseAuth? firebaseAuth,
  })  : _cache = cacheClient ?? CacheClient(),
        _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  final CacheClient _cache;
  final firebase_auth.FirebaseAuth _firebaseAuth;

  static const userCacheKey = "__user_cache_key__";

  /// Stream of [User] which will emit the current user when
  /// the authentication state changes.
  ///
  /// Emits [User.empty] if the user is not authenticated.
  Stream<User> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      final user = firebaseUser == null ? User.empty : firebaseUser.toUser;
      _cache.write(key: userCacheKey, value: user);
      return user;
    });
  }

  /// Returns the current cached user
  /// Defaults to [user.empty] if there is no cached user.
  User get currentUser {
    return _cache.read<User>(key: userCacheKey) ?? User.empty;
  }

  /// creates a new user with the provided [email] and [password].
  ///
  /// Throw a [signUpWithEmailAndPasswordFailure] if an exceptionoccurs.
  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw SignUpWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const SignUpWithEmailAndPasswordFailure();
    }
  }

  /// Signs in with the provided [email] and [password].
  ///
  /// Throws a [LogInWithEmailAndPasswordFailure] if an exception occurs.
  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw LogInWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const LogInWithEmailAndPasswordFailure();
    }
  }

  /// SignIn with Phone number
  ///
  /// Throws a [LogInWithPhoneNumberFailure] if an exception occurs.
  Future<void> logInWithPhoneNumber({
    required String phoneNumber,
    required Function(firebase_auth.PhoneAuthCredential) verificationCompleted,
    required Function(firebase_auth.FirebaseAuthException) verificationFailed,
    required Function(String, int?) codeSent,
    required Function(String) codeAutoRetrievalTimeout,
  }) async {
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: "+213$phoneNumber",
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  /// Signs In with Credential
  ///
  /// Throws a [LogInWithCredentialFailure] if an Exception occurs.
  Future<User?> logInWithCredential({
    required firebase_auth.AuthCredential credential,
  }) async {
    try {
      final userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      return userCredential.user?.toUser;
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw LogInWithCredentialFailure.fromCode(e.code);
    } catch (e) {
      throw LogInWithCredentialFailure();
    }
  }

  /// Signs out the current user which will
  /// emit [User.empty] from the [User] stream.
  ///
  /// Throws a [LogOutFailure] if an exception occurs
  Future<void> logOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
      ]);
    } catch (_) {
      throw LogOutFailure();
    }
  }

  bool isLoggedIn() => _firebaseAuth.currentUser != null;
}

extension on firebase_auth.User {
  User get toUser {
    return User(
      id: uid,
      email: email,
      UserName: displayName,
      photo: photoURL,
      phoneNumber: phoneNumber,
    );
  }
}
