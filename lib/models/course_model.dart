// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

class CourseModel {
  final int id;
  final String name;
  final bool isStudent;

  CourseModel({
    required this.id,
    required this.name,
    required this.isStudent,
  });

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'isStudent': isStudent};
  }

  String toJson() => json.encode(toMap());

  factory CourseModel.fromMap(Map<String, dynamic> map) {
    return CourseModel(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      isStudent: map['isStudent'] ?? false,
    );
  }

  factory CourseModel.fromJson(String source) => CourseModel.fromMap(json.decode(source) ?? {});

  @override
  String toString() {
    return '''
    id -> $id
    name -> $name
    isStudent -> $isStudent
''';
  }
}
