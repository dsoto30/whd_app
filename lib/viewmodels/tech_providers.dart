import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whd_app/models/tech.dart';
import 'package:whd_app/repositories/tech_repository.dart';
import 'package:whd_app/viewmodels/auth_controller.dart';

/// Session-authenticated views of the Tech resource. Both read the current
/// [Session] from [authControllerProvider]; the Home screen (their only
/// consumer) is unreachable without a session, so a null session is an error.

/// The currently logged-in tech (`GET /ra/Techs/{currentTechId}`).
final currentTechProvider = FutureProvider<Tech>((ref) async {
  final session = ref.watch(authControllerProvider);
  if (session == null) {
    throw StateError('No active session');
  }
  return ref.watch(techRepositoryProvider).getCurrentTech(session: session);
});

/// Every tech on the team (`GET /ra/Techs`).
final teamTechsProvider = FutureProvider<List<Tech>>((ref) async {
  final session = ref.watch(authControllerProvider);
  if (session == null) {
    throw StateError('No active session');
  }
  return ref.watch(techRepositoryProvider).getAllTechs(session: session);
});
