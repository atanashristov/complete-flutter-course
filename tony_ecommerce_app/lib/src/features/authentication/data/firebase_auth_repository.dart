import 'package:tony_ecommerce_app/src/features/authentication/data/auth_repository.dart';
import 'package:tony_ecommerce_app/src/features/authentication/domain/app_user.dart';

class FirebaseAuthRepository implements AuthRepository {
  @override
  Stream<AppUser?> get authStateChanges {
    throw UnimplementedError();
  }

  @override
  AppUser? get currentUser {
    throw UnimplementedError();
  }

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    throw UnimplementedError();
  }

  @override
  Future<void> createUserWithEmailAndPassword(String email, String password) async {
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() async {
    throw UnimplementedError();
  }
}
