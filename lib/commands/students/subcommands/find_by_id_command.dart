// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:args/command_runner.dart';

import '../../../repositories/student_dio_repository.dart';
import '../../../repositories/student_repository.dart';

class FindByIdCommand extends Command {
  final StudentDioRepository repository;

  @override
  String get description => 'Find student by id';

  @override
  String get name => 'findId';

  FindByIdCommand(
    this.repository,
  ){
    argParser.addOption('id', help: 'Student id', abbr: 'i');
  }

  @override
  void run() async {
    if(argResults?['id'] == null){
      print('Por favor envie o id do aluno com o comando --d=0 ou -i 0');
      return;
    }
    final id = int.parse(argResults?['id']);
    
    print('Aguarde buscando dados...');
    final student = await repository.findById(id);
    print(student);
    print('------------------------------------------');
    print('Aluno ${student.name}');
    print('------------------------------------------');
    print('Nome: ${student.name}');
    print('Idade: ${student.age  ?? 'Não informada'}');
    print('Curso: ');
    student.nameCourses.forEach(print);
    print('Endereço: ');
    print('     ${student.address.street} (${student.address.zipCode})');


  }
  
}
