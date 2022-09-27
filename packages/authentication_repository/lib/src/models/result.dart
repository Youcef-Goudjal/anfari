import 'package:firebase_auth/firebase_auth.dart';

class LoginResult {
  String phone;
  Duration? timeOut;
  void Function(PhoneAuthCredential)? verificationCompleted;
  void Function(FirebaseAuthException)? verificationFailed;
  void Function(String, int?)? codeSent;
  Function(String)? codeAutoRetrievalTimeout;
  LoginResult({
    this.phone = "",
    this.timeOut = const Duration(seconds: 15),
    this.codeAutoRetrievalTimeout,
    this.codeSent,
    this.verificationCompleted,
    this.verificationFailed,
  });
}
