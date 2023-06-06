import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:dart_cli/commands/students/students_command.dart';

void main(List<String> arguments) {
  // final argParser = ArgParser();
  // argParser.addFlag('data', abbr: 'd');
  // argParser.addOption('name',abbr: 'n');
  // argParser.addOption('template',abbr: 't');
  // final argResult = argParser.parse(arguments);

  CommandRunner('ADF CLI', 'Dart CLI')
    ..addCommand(StudentsCommand())
    ..run(arguments);
}

class ExemploCommand extends Command {
  @override
  String get description => 'Exemplo de comando';

  @override
  String get name => 'exemplo';

  ExemploCommand(){
    argParser.addOption('template',abbr: 't', help: 'Template de criação do projeto');
  }

  @override
  void run() {
    print(argResults?['template']);
    print('Executar qualque coisa');
  }
}
