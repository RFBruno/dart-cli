import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/student_model.dart';

class StudentRepository {
  Future<List<StudentModel>> findAll() async {
    final response =
        await http.get(Uri.parse('http://localhost:8080/students'));

    if (response.statusCode != 200) {
      throw Exception('Status diferente de 200');
    }

    final responseData = jsonDecode(response.body);

    if (responseData.isEmpty) {
      throw Exception('Nenhum estudante retornado');
    }

    return responseData
        .map<StudentModel>((s) => StudentModel.fromMap(s))
        .toList();
  }

  Future<StudentModel> findById(int id) async {
    final response =
        await http.get(Uri.parse('http://localhost:8080/students/$id'));

    if (response.statusCode != 200) {
      throw Exception('Status diferente de 200');
    }

    if (response.body == '{}') {
      throw Exception('Nenhum estudante retornado');
    }

    return StudentModel.fromJson(response.body);
  }

  Future<void> insert(StudentModel student) async {
    final response = await http.post(
        Uri.parse('http://localhost:8080/students'),
        body: student.toJson(),
        headers: {'Content-Type': 'Application/json'});

    if (response.statusCode != 200) {
      throw Exception('Status diferente de 200');
    }
  }

  Future<void> update(StudentModel student) async {
    final response = await http.put(
      Uri.parse('http://localhost:8080/students/${student.id}'),
      body: student.toJson(),
      headers: {
        'Content-Type' : 'Application/json'
      }
    );
    if (response.statusCode != 200) {
      throw Exception('Status diferente de 200');
    }
  }

  Future<void> delete(int id) async {
    final response = await http.delete(Uri.parse('http://localhost:8080/students/$id'));

    if (response.statusCode != 200) {
      throw Exception('Status diferente de 200');
    }
  }
}
