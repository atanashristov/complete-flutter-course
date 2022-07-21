# tony_ecommerce_app

Tony's eCommerce App

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Repositories

### Abstract class and implementations

For the _authentication_ feature we create abstract repository `AuthRepository` and 2 implementations: `FakeAuthRepository` and `FirebaseAuthRepository`. Then we define the auth Riverpod providers and we select the one or the other repository using environment variable 'USE_FAKE_REPOS':

```dart
// features/authentication/data/auth_providers.dart

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
```

We can set environment variables at compile time with the `--dart-define` command line argument like `--dart-define=USE_FAKE_REPOS=true`.

We can set this environment variable in the `.vscode/launch.json` like so:

```json
  "configurations": [
    {
      "name": "tony_ecommerce_app",
      "request": "launch",
      "type": "dart",
      "toolArgs": [
        "--dart-define",
        "USE_FAKE_REPOS=true"
      ]
    },
```

### Hold in-memory state

For fake repositories we just want to keep state in-memory. The state will reset upon hot restart, but this is fine.

The repository provides state changes to listeners as a stream `authStateChangesProvider`.
We have several options to implement _reactive in-memory store_ for our state. For this we have several options.

One option is to use the `StreamController` from the `dart:async` package. We have two requirements:

- Support multiple listeners
  - We can use `SteamController.broadcast()`
- We have to _remember the last value_
  - We should be able to return it when a new widget was created and added as a listener
  - This is _not supported_ by `StreamControler` class.

A better option is to use [BehaviourSubject](https://pub.dev/documentation/rxdart/latest/rx/BehaviorSubject-class.html) class from the [RxDart package](https://pub.dev/packages/rxdart). It comes out of the box with support for remembering the last value and multiple listeners.

We create in-memory store for all the repositories in `utils/in_memory_store.dart`.

## UI

### ConsumerWidget

`ConsumerWidget` provides a reference to `WidgetRef` that allows interaction with the providers:

```dart
class AccountScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ...
          ActionTextButton(
            onPressed: () async {
              ...
                await ref.read(authRepositoryProvider).signOut();
                Navigator.of(context).pop();
```

Inside the `build()` method we can get access to values from the providers in two ways:

- use `ref.watch()` when you want to rebuild the widget when data changes
- use `ref.read()` inside button callbacks, when you do not need rebuild
- use `ref.listen()` to listen and run when state changed without rebuilding the widget

### Controllers

Controllers purpose is to:

- Manage widgets state
- Mediate between the widget and other layers

Controllers are similar to:

- View models in MVVM architecture
- Blocs in BloC architecture

Controllers with Riverpod are based on `StateNotifier` from Riverpod. These are similar to:

- ValueNotifier/ChangeNotifier from Flutter SDK
- Cubit from BloC package

Controllers should never depend on `BuildContext`.
