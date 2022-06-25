import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tony_ecommerce_app/src/features/authentication/domain/app_user.dart';

class FakeAuthRepository {
  Stream<AppUser?> get authStateChanges => Stream.value(null);

  AppUser? get currentUser => null;

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
  }

  Future<void> createUserWithEmailAndPassword(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
  }

  Future<void> signOut() async {
    await Future.delayed(const Duration(seconds: 1));
  }
}

final authRepositoryProvider = Provider<FakeAuthRepository>((ref) => FakeAuthRepository());

final authStateChangesProvider = StreamProvider.autoDispose<AppUser?>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.authStateChanges;
});
