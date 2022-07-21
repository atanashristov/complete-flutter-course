import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tony_ecommerce_app/src/features/authentication/data/auth_providers.dart';
import 'package:tony_ecommerce_app/src/features/authentication/data/auth_repository.dart';

class AccountScreenController extends StateNotifier<AsyncValue<void>> {
  final AuthRepository authRepository;

  AccountScreenController({
    required this.authRepository,
  }) : super(const AsyncValue.data(null));

  Future<void> signOut() async {
    try {
      state = const AsyncValue.loading();
      await authRepository.signOut();
      state = const AsyncValue.data(null);
    } catch (e) {
      state = AsyncValue.error(e);
    }
  }
}

final accountScreenControllerProvider =
    StateNotifierProvider.autoDispose<AccountScreenController, AsyncValue<void>>((ref) {
  final authRepository = ref.read(authRepositoryProvider);
  return AccountScreenController(authRepository: authRepository);
});
