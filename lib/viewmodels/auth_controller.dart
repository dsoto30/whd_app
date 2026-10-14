import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whd_app/models/session.dart';

/// App-wide authentication state. Holds the current [Session] (including the
/// session key used for subsequent authenticated requests), or `null` when
/// logged out. In-memory only for now.
class AuthController extends Notifier<Session?> {
  @override
  Session? build() => null;

  void set(Session session) => state = session;

  void logout() => state = null;
}

final authControllerProvider = NotifierProvider<AuthController, Session?>(
  AuthController.new,
);
