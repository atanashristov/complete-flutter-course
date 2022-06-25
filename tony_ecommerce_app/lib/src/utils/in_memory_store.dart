import 'package:rxdart/rxdart.dart';

/// InMemoryStore is a simple in-memory store that can be used for testing.
/// It is backed by BehaviorSubject, so it can be used in a way that is similar to a stream.
/// It can store the data for all fake repositories in the app.
class InMemoryStore<T> {
  /// The BehaviorSubject that holds the data.
  final BehaviorSubject<T> _subject;

  InMemoryStore(T initialValue) : _subject = BehaviorSubject<T>.seeded(initialValue);

  /// The output stream that can be used to listen to the data.
  Stream<T> get stream => _subject.stream;

  /// A synchronous getter for the current value.
  T get value => _subject.value;

  /// A setter for updating the value.
  set value(T value) => _subject.add(value);

  /// Don't forget to close once done.
  void close() => _subject.close();
}
