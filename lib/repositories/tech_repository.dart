import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whd_app/models/tech.dart';
import 'package:whd_app/providers/api_service_provider.dart';
import 'package:whd_app/services/whd_api_service.dart';
import 'package:whd_app/models/session.dart';

/// Owns the Web Help Desk "Tech" resource: knows the endpoint path,
/// builds query parameters, and maps the raw JSON response to [Tech].
///
/// Sits between the generic transport layer ([WhdApiService]) and the
/// view models, so view logic never deals with HTTP or JSON directly.

class TechRepository {
  TechRepository(this._api);

  final WhdApiService _api;

  //Obtain all techs
  Future<List<Tech>> getAllTechs({required Session session}) async {
    final data = await _api.get(
      url: "/ra/Techs",
      query: {"sessionKey": session.sessionKey},
    );

    return (data as List<dynamic>)
        .map((json) => Tech.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<Tech> getCurrentTech({required Session session}) async {
    final data = await _api.get(
      url: "/ra/Techs/${session.currentTechId}",
      query: {"sessionKey": session.sessionKey},
    );

    return Tech.fromJson(data as Map<String, dynamic>);
  }
}

final techRepositoryProvider = Provider<TechRepository>(
  (ref) => TechRepository(ref.watch(apiServiceProvider)),
);
