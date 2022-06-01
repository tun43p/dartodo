import 'package:dartodo/action.dart';

void main(List<String> arguments) {
  if (arguments.isEmpty) {
    throw Exception('Please specify an argument.');
  }

  if (Action.create.triggers.contains(arguments.first)) {
    if (arguments.length != 2) {
      throw Exception('You need to specify a content.');
    }

    Action.create.exec(content: arguments.last);
  } else if (Action.delete.triggers.contains(arguments.first)) {
    if (arguments.length != 2) {
      throw Exception('You need to specify an id.');
    }

    Action.delete.exec(id: int.parse(arguments.last));
  } else if (Action.list.triggers.contains(arguments.first)) {
    Action.list.exec();
  } else {
    throw Exception('Invalid argument.');
  }
}
