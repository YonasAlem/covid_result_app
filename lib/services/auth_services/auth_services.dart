import 'auth_provider.dart';
import 'auth_user.dart';
import 'firebase_auth_provider.dart';

class AuthServices implements AuthProvider {
  final AuthProvider provider;

  AuthServices(this.provider);

  factory AuthServices.firebase() => AuthServices(FirebaseAuthProvider());

  @override
  AuthUser? get currentUser {
    return provider.currentUser;
  }

  @override
  Future<void> initialize() {
    return provider.initialize();
  }

  @override
  Future<AuthUser> login({required String email, required String password}) {
    return provider.login(email: email, password: password);
  }

  @override
  Future<void> logout() {
    return provider.logout();
  }

  @override
  Future<AuthUser> register({required String email, required String password}) {
    return provider.register(email: email, password: password);
  }

  @override
  Future<void> sendEmailVerification() {
    return provider.sendEmailVerification();
  }
}
