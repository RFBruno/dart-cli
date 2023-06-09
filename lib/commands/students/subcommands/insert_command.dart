import 'dart:io';

import 'package:args/command_runner.dart';

import '../../../models/address_model.dart';
import '../../../models/city_model.dart';
import '../../../models/phone_model.dart';
import '../../../models/student_model.dart';
import '../../../repositories/product_repository.dart';
import '../../../repositories/student_repository.dart';

class InsertCommand extends Command {
  final StudentRepository studentRepository;
  final productRepository = ProductRepository();

  @override
  String get description => 'Students insert path';

  @override
  String get name => 'insert';

  InsertCommand(this.studentRepository) {
    argParser.addOption('file', help: 'Path of the csv file', abbr: 'f');
  }

  @override
  void run() async {
    print('Aguarde....');
    final filePath = argResults?['file'];
    final students = File(filePath).readAsLinesSync();

    for (var student in students) {
      final studentData = student.split(',');
      var coursesName = <String>[];
      final coursesFuture = studentData[2].split(';').map((c) async {
        coursesName.add(c.trim());
        final course = await productRepository.findByName(c.trim());
        course.isStudent = true;
        return course;
      }).toList();

      final coursesData = await Future.wait(coursesFuture);

      final studentModel = StudentModel(
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

      studentRepository.insert(studentModel);
    }
      print('------------------------------------------------------');
      print('Alunos adicionados com sucesso');
  }
}
