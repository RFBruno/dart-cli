import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import '../models/student_model.dart';

class StudentDioRepository {
  final dio = Dio();
  Future<List<StudentModel>> findAll() async {
    try {
      final response = await dio.get('http://localhost:8080/students');

      if (response.data.isEmpty) {
        throw Exception('Nenhum estudante retornado');
      }

      return response.data
          .map<StudentModel>((s) => StudentModel.fromMap(s))
          .toList();
    } on DioException {
      throw Exception();
    }
  }

  Future<StudentModel> findById(int id) async {
    try {
      final response = await dio.get(
        'http://localhost:8080/students/$id',
      );

      if (response.data == null) {
        throw Exception('Nenhum estudante retornado');
      }

      return StudentModel.fromMap(response.data);
    } on DioException {
      throw Exception();
    }
  }

  Future<void> insert(StudentModel student) async {
    try {
      await dio.post(
        'http://localhost:8080/students',
        data: student.toMap(),
      );
    } on DioException catch (e) {
      print(e);
      throw Exception();
    }
  }

  Future<void> update(StudentModel student) async {
    try {
      await dio.put(
        'http://localhost:8080/students/${student.id}',
        data: student.toMap(),
      );
    } on DioException catch (e) {
      print(e);
      throw Exception();
    }
  }

  Future<void> delete(int id) async {
    try {
      await dio.delete(
        'http://localhost:8080/students/$id',
      );
    } on DioException catch (e) {
      print(e);
      throw Exception();
    }
  }
}
