// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:args/command_runner.dart';
import '../../../models/student_model.dart';
import '../../../repositories/student_dio_repository.dart';
import '../../../repositories/student_repository.dart';

class DeleteCommand extends Command {
  final StudentDioRepository studentRepository;

  @override
  String get description => 'Delete student';
  
  @override
  String get name => 'delete';

  DeleteCommand(
    this.studentRepository,
  ) : super(){
    argParser.addOption('id', help: 'Student id', abbr: 'i');
  }

  @override
  Future<void> run() async {
    final studentId = int.tryParse(argResults?['id']);
    
    if(studentId == null){
      print('O id do estudante é obrigatorio');
      return;
    }

    final StudentModel student = await studentRepository.findById(studentId);

    print('Voce tem certeza que deseja deletar o aluno ${student.name}? (S ou N)');
    final resposta = stdin.readLineSync();

    if(resposta?.toUpperCase() == 'S'){
        await studentRepository.delete(studentId);
        print('Aluno deletado com sucesso.');
    }else{
      print('Operação cancelada');
    }


  }
}
