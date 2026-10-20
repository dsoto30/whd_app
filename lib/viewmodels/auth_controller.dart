import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whd_app/models/session.dart';
import 'package:whd_app/repositories/session_repository.dart';

/// App-wide authentication state. Holds the current [Session] (including the
/// session key used for subsequent authenticated requests), or `null` when
/// logged out. In-memory only for now.
class AuthController extends Notifier<Session?> {
  @override
  Session? build() => null;

  void set(Session session) => state = session;

  /// Deletes the session on the server (`DELETE /ra/Session`) and clears the
  /// in-memory session. Local state is cleared regardless of whether the
  /// server call succeeds, so the user is always logged out locally.
  Future<void> logout() async {
    final session = state;
    if (session != null) {
      try {
        await ref
            .read(sessionRepositoryProvider)
            .deleteSession(session: session);
      } catch (_) {
        // Ignore: logging out locally must succeed even if the server
        // call fails (e.g. offline or already-expired session).
      }
    }
    state = null;
  }
}

final authControllerProvider = NotifierProvider<AuthController, Session?>(
  AuthController.new,
);
