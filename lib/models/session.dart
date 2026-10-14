// To parse this JSON data, do
//
//     final session = sessionFromJson(jsonString);

import 'dart:convert';

Session sessionFromJson(String str) => Session.fromJson(json.decode(str));

String sessionToJson(Session data) => json.encode(data.toJson());

class Session {
  final String type;
  final String sessionKey;
  final int currentTechId;
  final int instanceId;

  Session({
    required this.type,
    required this.sessionKey,
    required this.currentTechId,
    required this.instanceId,
  });

  factory Session.fromJson(Map<String, dynamic> json) => Session(
    type: json["type"],
    sessionKey: json["sessionKey"],
    currentTechId: json["currentTechId"],
    instanceId: json["instanceId"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "sessionKey": sessionKey,
    "currentTechId": currentTechId,
    "instanceId": instanceId,
  };
}
