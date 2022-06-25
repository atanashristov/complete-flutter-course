import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tony_ecommerce_app/src/features/authentication/data/auth_repository.dart';
import 'package:tony_ecommerce_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:tony_ecommerce_app/src/features/authentication/data/firebase_auth_repository.dart';
import 'package:tony_ecommerce_app/src/features/authentication/domain/app_user.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  // This can be set at run time via --dart-define=USE_FAKE_REPOS=true.
  // flutter run --dart-define USE_FAKE_REPOS="true"
  const useFakeRepos = String.fromEnvironment('USE_FAKE_REPOS', defaultValue: 'false') == 'true';
  return useFakeRepos ? FakeAuthRepository() : FirebaseAuthRepository();
});

final authStateChangesProvider = StreamProvider.autoDispose<AppUser?>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.authStateChanges;
});
