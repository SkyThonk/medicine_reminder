import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../services/authentication_service.dart';

abstract class AuthenticationRepository {
  Future<bool> signIn({required String email, required String password});
  Future<bool> signInWithGoogle();
  Future<bool> signUp({required String email, required String password});
  Future<void> signOut();
}

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationService _authenticationService;
  AuthenticationRepositoryImpl(
      {required FirebaseAuth? firebaseAuth, GoogleSignIn? googleSignIn})
      : _authenticationService = AuthenticationService(
            firebaseAuth: firebaseAuth, googleSignIn: googleSignIn);

  @override
  Future<bool> signIn({required String email, required String password}) async {
    return await _authenticationService.signIn(
        email: email, password: password);
  }

  @override
  Future<bool> signInWithGoogle() async {
    return await _authenticationService.signInWithGoogle();
  }

  @override
  Future<bool> signUp({required String email, required String password}) async {
    return await _authenticationService.signUp(
        email: email, password: password);
  }

  @override
  Future<void> signOut() async {
    return await _authenticationService.signOut();
  }
}
