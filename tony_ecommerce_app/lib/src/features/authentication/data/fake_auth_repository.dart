import 'package:tony_ecommerce_app/src/features/authentication/data/auth_repository.dart';
import 'package:tony_ecommerce_app/src/features/authentication/domain/app_user.dart';

class FakeAuthRepository implements AuthRepository {
  @override
  Stream<AppUser?> get authStateChanges => Stream.value(null);

  @override
  AppUser? get currentUser => null;

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<void> createUserWithEmailAndPassword(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<void> signOut() async {
    await Future.delayed(const Duration(seconds: 1));
  }
}
