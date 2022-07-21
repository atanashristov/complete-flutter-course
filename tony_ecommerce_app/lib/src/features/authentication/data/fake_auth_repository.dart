import 'package:tony_ecommerce_app/src/features/authentication/data/auth_repository.dart';
import 'package:tony_ecommerce_app/src/features/authentication/domain/app_user.dart';
import 'package:tony_ecommerce_app/src/utils/in_memory_store.dart';

class FakeAuthRepository implements AuthRepository {
  final _authState = InMemoryStore<AppUser?>(null);

  @override
  Stream<AppUser?> get authStateChanges => _authState.stream;

  @override
  AppUser? get currentUser => _authState.value;

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    if (currentUser == null) {
      _createUser(email);
    }
  }

  @override
  Future<void> createUserWithEmailAndPassword(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    if (currentUser == null) {
      _createUser(email);
    }
  }

  @override
  Future<void> signOut() async {
    await Future.delayed(const Duration(seconds: 1));
    // throw Exception('Connection failed');
    _authState.value = null;
  }

  @override
  void dispose() => _authState.close();

  void _createUser(String email) {
    _authState.value = AppUser(
      uid: email.split('').reversed.join(),
      email: email,
    );
  }
}
