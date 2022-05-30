import 'package:firebase_auth/firebase_auth.dart';

class AuthUser {
  final bool isEmailVerified;
  final String email;

  AuthUser({required this.isEmailVerified, required this.email});

  factory AuthUser.fromFirebase(User user) {
    return AuthUser(
      isEmailVerified: user.emailVerified,
      email: user.email!,
    );
  }
}
