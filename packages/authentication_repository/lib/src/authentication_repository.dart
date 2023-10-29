import 'dart:async';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

/// AuthenticationRepository exposes a Stream of AuthenticationStatus updates
/// which will be used to notify the application when a user signs in or out.
class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<void> logIn({
    required String username,
    required String password,
  }) async {
    await Future.delayed(
      const Duration(milliseconds: 300),
      () => _controller.add(AuthenticationStatus.authenticated),
    );
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  // Dispose method is exposed so that the controller can be closed when no
  // no longer needed. This is necessary since we're maintaining a
  // StreamController internally.
  void dispose() => _controller.close();
}
