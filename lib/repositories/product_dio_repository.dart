
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import '../models/course_model.dart';

class ProductDioRepository {
  final dio =  Dio();

  Future<CourseModel> findByName(String name) async {
    // final response = await http.get(Uri.parse('http://localhost:8080/products?name=$name'));
    
    final response = await dio.get('http://localhost:8080/products?name=$name');

    if (response.data.isEmpty) {
      throw Exception('Produto não encontrado');
    }

    return CourseModel.fromMap(response.data);
  }
}