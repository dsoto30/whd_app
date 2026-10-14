import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whd_app/models/session.dart';
import 'package:whd_app/providers/api_service_provider.dart';
import 'package:whd_app/services/whd_api_service.dart';

/// Owns the Web Help Desk "Session" resource: knows the endpoint path,
/// builds query parameters, and maps the raw JSON response to [Session].
///
/// Sits between the generic transport layer ([WhdApiService]) and the
/// view models, so view logic never deals with HTTP or JSON directly.
class SessionRepository {
  SessionRepository(this._api);

  final WhdApiService _api;

  /// Authenticates against `GET /ra/Session` and returns the session.
  Future<Session> createSession({
    required String username,
    required String password,
  }) async {
    final data = await _api.get(
      url: '/ra/Session',
      query: {'username': username, 'password': password},
    );

    return Session.fromJson(data as Map<String, dynamic>);
  }
}

final sessionRepositoryProvider = Provider<SessionRepository>(
  (ref) => SessionRepository(ref.watch(apiServiceProvider)),
);
