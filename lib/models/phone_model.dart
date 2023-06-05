// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

class PhoneModel {
  final int ddd;
  final String phone;

  PhoneModel({
    required this.ddd,
    required this.phone,
  });

  Map<String, dynamic> toMap() {
    return {'ddd': ddd, 'phone': phone};
  }

  String toJson() => json.encode(toMap());

  factory PhoneModel.fromMap(Map<String, dynamic> map) {
    return PhoneModel(
      ddd: map['ddd'] ?? 0,
      phone: map['phone'] ?? '',
    );
  }

  factory PhoneModel.fromJson(String source) => PhoneModel.fromMap(json.decode(source));
}
