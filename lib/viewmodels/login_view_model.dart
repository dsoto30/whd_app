import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whd_app/repositories/session_repository.dart';
import 'package:whd_app/viewmodels/auth_controller.dart';

/// Drives the login screen. Exposes loading/error state via [AsyncValue];
/// on success it writes the returned session into [authControllerProvider].
class LoginViewModel extends AsyncNotifier<void> {
  @override
  void build() {}

  Future<void> login({
    required String username,
    required String password,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final session = await ref
          .read(sessionRepositoryProvider)
          .createSession(username: username, password: password);
      ref.read(authControllerProvider.notifier).set(session);
    });
  }
}

final loginViewModelProvider =
    AsyncNotifierProvider<LoginViewModel, void>(LoginViewModel.new);
