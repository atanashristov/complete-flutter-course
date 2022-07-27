import 'package:flutter_test/flutter_test.dart';
import 'package:tony_ecommerce_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:tony_ecommerce_app/src/features/authentication/domain/app_user.dart';

void main() {
  const testEmail = 'test@test.com';
  const testPassword = 'test1234';
  final testUser = AppUser(
    uid: testEmail.split('').reversed.join(),
    email: testEmail,
  );
  FakeAuthRepository makeAuthRepository() => FakeAuthRepository(addDelay: false);

  group('FakeAuthRepository', () {
    test('currentUser is null by default', () {
      final authRepository = makeAuthRepository();
      expect(authRepository.currentUser, null);
      expect(authRepository.authStateChanges, emits(null));
    });

    test('currentUser is not null after sign in', () async {
      final authRepository = makeAuthRepository();
      await authRepository.signInWithEmailAndPassword(testEmail, testPassword);
      expect(authRepository.currentUser, testUser);
      expect(authRepository.authStateChanges, emits(testUser));
    });

    test('currentUser is not null after registration', () async {
      final authRepository = makeAuthRepository();
      await authRepository.createUserWithEmailAndPassword(testEmail, testPassword);
      expect(authRepository.currentUser, testUser);
      expect(authRepository.authStateChanges, emits(testUser));
    });

    test('currentUser is null after sign out', () async {
      final authRepository = makeAuthRepository();
      await authRepository.signInWithEmailAndPassword(testEmail, testPassword);
      expect(authRepository.currentUser, testUser);
      // This will not work, because BehaviorSubject is designed
      // to remember only it's last value.
      // expect(authRepository.authStateChanges, testUser);

      // This will not work **if after signOut()**, because BehaviorSubject is designed
      // to remember only it's last value.
      // We have to give the matcher a chance to read the first value.
      // That's why we put it in here, before the call to signOut(), right after first call to signIn().
      expect(
        authRepository.authStateChanges,
        // It will wait until it sees all the emits listed in here.
        emitsInOrder([
          testUser, // after sign in
          null, // after sign out
        ]),
      );

      await authRepository.signOut();
      expect(authRepository.currentUser, null);
    });

    test('Sign in after dispose throws exception', () {
      final authRepository = makeAuthRepository();
      authRepository.dispose();
      expect(
        () => authRepository.signInWithEmailAndPassword(testEmail, testPassword),
        throwsStateError,
      );
    });
  });
}
