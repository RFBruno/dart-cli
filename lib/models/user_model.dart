import 'dart:convert';

class UserModel {
  final int id;
  final String name;
  final String email;
  final String? password;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
    );
  }

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) ?? {});


}
