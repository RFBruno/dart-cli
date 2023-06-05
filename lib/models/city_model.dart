// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

class CityModel {
  final int id;
  final String name;

  CityModel({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name};
  }

  String toJson() => json.encode(toMap());

  factory CityModel.fromMap(Map<String, dynamic> map) {
    return CityModel(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
    );
  }

  factory CityModel.fromJson(String source) => CityModel.fromMap(json.decode(source) ?? {});
}
