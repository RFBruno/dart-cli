
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/course_model.dart';

class ProductRepository {
  
  Future<CourseModel> findByName(String name) async {
    final response = await http.get(Uri.parse('http://localhost:8080/products?name=$name'));
    if(response.statusCode != 200){
      throw Exception('Diferente de 200');
    }

    final resposeData = jsonDecode(response.body);

    if (resposeData.isEmpty) {
      throw Exception('Produto não encontrado');
    }

    return CourseModel.fromMap(resposeData.first);
  }
}