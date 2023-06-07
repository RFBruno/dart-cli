// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'address_model.dart';
import 'course_model.dart';

class StudentModel {
  final int? id;
  final String name;
  final int? age;
  final List<String> nameCourses;
  final List<CourseModel> courses;
  final AddressModel address;

  StudentModel({
    this.id,
    required this.name,
    this.age,
    required this.nameCourses,
    required this.courses,
    required this.address,
  });

  Map<String, dynamic> toMap() {
    final map = {
      'id': id,
      'name': name,
      'age': age,
      'nameCourses': nameCourses,
      'courses': courses.map((c) => c.toMap()).toList(),
      'address': address.toMap(),
    };

    if (age != null) {
      map['age'] = age;
    }

    return map;
  }

  String toJson() => jsonEncode(toMap());

  factory StudentModel.fromMap(Map<String, dynamic> map) {
    return StudentModel(
      id: map['id'] ?? null,
      name: map['name'] ?? '',
      age: map['age'] ?? null,
      nameCourses: List<String>.from(map['nameCourses'] ?? <String>[]),
      courses: map['courses']
              ?.map<CourseModel>((c) => CourseModel.fromMap(c))
              .toList() ??
          <CourseModel>[],
      address: AddressModel.fromMap(map['address'] ?? {}),
    );
  }

  factory StudentModel.fromJson(String source) =>
      StudentModel.fromMap(jsonDecode(source) ?? {});

  @override
  String toString() {
    return '''
        id -> $id
        name -> $name
        age -> $age
        nameCourses -> $nameCourses
        courses -> $courses
        address -> $address
''';
  }
}
