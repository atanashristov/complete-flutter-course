import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tony_ecommerce_app/src/features/authentication/data/auth_providers.dart';
import 'package:tony_ecommerce_app/src/features/authentication/data/auth_repository.dart';

class AccountScreenController extends StateNotifier<AsyncValue> {
  AccountScreenController({
    required this.authRepository,
  }) : super(const AsyncValue.data(null));

  final AuthRepository authRepository;

  // Future<bool> signOut() async {
  //   // try {
  //   //   state = const AsyncValue.loading();
  //   //   await authRepository.signOut();
  //   //   state = const AsyncValue.data(null);
  //   //   return true;
  //   // } catch (e) {
  //   //   state = AsyncValue.error(e);
  //   //   return false;
  //   // }

  //   state = const AsyncValue.loading();
  //   state = await AsyncValue.guard(() => authRepository.signOut());
  //   return state.hasError == false;
  // }

  /// It signs out the user.
  /// No need to return success or failure, we can use `refreshListenable` with `GoRouter`.
  Future<void> signOut() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => authRepository.signOut());
  }
}

final accountScreenControllerProvider = StateNotifierProvider.autoDispose<AccountScreenController, AsyncValue>((ref) {
  final authRepository = ref.read(authRepositoryProvider);
  return AccountScreenController(authRepository: authRepository);
});
