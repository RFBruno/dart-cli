// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';
import 'package:args/command_runner.dart';

import '../../../models/address_model.dart';
import '../../../models/city_model.dart';
import '../../../models/course_model.dart';
import '../../../models/phone_model.dart';
import '../../../models/student_model.dart';
import '../../../repositories/product_repository.dart';
import '../../../repositories/student_dio_repository.dart';
import '../../../repositories/student_repository.dart';

class UpdateCommand extends Command {

  final StudentDioRepository studentRepository;
  final productRepository = ProductRepository();

  @override
  String get description => 'Update student';
  
  @override
  String get name => 'update';
  
  UpdateCommand(
    this.studentRepository,
  ) : super(){
    argParser.addOption('file', help: 'Path of the csv', abbr: 'f');
    argParser.addOption('id', help: 'Student id', abbr: 'i');
  }

  @override
  Future<void> run() async {
print('Aguarde....');
    final filePath = argResults?['file'];
    final student = File(filePath).readAsLinesSync();
    final studentId =  argResults?['id'];

    if(studentId == null){
      print('O argumento id é obrigatorio para atualização');
      return;
    }

    if(student.isEmpty){
      print('O arquivo enviar esta vazio');
      return;
    }else if(student.length > 1){
      print('Só pode ser passado um estudante por vez para atualização.');
      return;
    }



      final studentData = student.first.split(',');
      var coursesName = <String>[];
      final coursesFuture = studentData[2].split(';').map((c) async {
        coursesName.add(c.trim());
        final course = await productRepository.findByName(c.trim());
        course.isStudent = true;
        return course;
      }).toList();

      final coursesData = await Future.wait<CourseModel>(coursesFuture);

      final studentModel = StudentModel(
        id: int.tryParse(studentId),
        name: studentData[0],
        age: int.tryParse(studentData[1]),
        nameCourses: coursesName,
        courses: coursesData,
        address: AddressModel(
          street: studentData[3],
          number: int.parse(studentData[4]),
          zipCode: studentData[5],
          city: CityModel(id: 1, name: studentData[6]),
          phone: PhoneModel(
            ddd: int.parse(studentData[7]),
            phone: studentData[8],
          ),
        ),
      );

      studentRepository.update(studentModel);
    
      print('------------------------------------------------------');
      print('Aluno atualizado com sucesso');
  }
}
