
import 'package:args/command_runner.dart';

import '../../repositories/student_dio_repository.dart';
import '../../repositories/student_repository.dart';
import 'subcommands/delete_command.dart';
import 'subcommands/find_all_command.dart';
import 'subcommands/find_by_id_command.dart';
import 'subcommands/insert_command.dart';
import 'subcommands/update_command.dart';

class StudentsCommand  extends Command{
  @override
  String get description => 'Students Operations';

  @override
  String get name => 'students';

  StudentsCommand(){
    final studentRepository = StudentRepository();
    final studentDioRepository = StudentDioRepository();

    addSubcommand(FindAllCommand(studentDioRepository));
    addSubcommand(FindByIdCommand(studentDioRepository));
    addSubcommand(InsertCommand(studentDioRepository));
    addSubcommand(UpdateCommand(studentDioRepository));
    addSubcommand(DeleteCommand(studentDioRepository));
  }
  
}