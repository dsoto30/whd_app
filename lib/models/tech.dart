// To parse this JSON data, do
//
//     final tech = techFromJson(jsonString);

import 'dart:convert';

Tech techFromJson(String str) => Tech.fromJson(json.decode(str));

String techToJson(Tech data) => json.encode(data.toJson());

class Tech {
  final int id;
  final String type;
  final String displayName;

  Tech({required this.id, required this.type, required this.displayName});

  factory Tech.fromJson(Map<String, dynamic> json) => Tech(
    id: json["id"],
    type: json["type"],
    displayName: json["displayName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "displayName": displayName,
  };
}
