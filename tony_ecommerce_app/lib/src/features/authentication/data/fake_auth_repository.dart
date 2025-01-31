import 'package:tony_ecommerce_app/src/features/authentication/data/auth_repository.dart';
import 'package:tony_ecommerce_app/src/features/authentication/domain/app_user.dart';
import 'package:tony_ecommerce_app/src/utils/delay.dart';
import 'package:tony_ecommerce_app/src/utils/in_memory_store.dart';

class FakeAuthRepository implements AuthRepository {
  FakeAuthRepository({this.addDelay = true});

  final bool addDelay;
  final _authState = InMemoryStore<AppUser?>(null);

  @override
  Stream<AppUser?> get authStateChanges => _authState.stream;

  @override
  AppUser? get currentUser => _authState.value;

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await delay(addDelay);
    // throw Exception('Connection failed');
    _createUser(email);
  }

  @override
  Future<void> createUserWithEmailAndPassword(String email, String password) async {
    await delay(addDelay);
    _createUser(email);
  }

  @override
  Future<void> signOut() async {
    await delay(addDelay);
    // throw Exception('Connection failed');
    _authState.value = null;
  }

  @override
  void dispose() => _authState.close();

  void _createUser(String email) {
    // throw Exception('Connection failed');
    _authState.value = AppUser(
      uid: email.split('').reversed.join(),
      email: email,
    );
  }
}
