import 'dart:io';

import 'package:dartodo/constants.dart';
import 'package:dartodo/todo.dart';

enum Action {
  create(['-c', '--create']),
  delete(['-d', '--delete']),
  list(['-l', '--list']);

  const Action(this.triggers);

  final List<String> triggers;

  Future<void> exec({String? content, int? id}) async {
    final file = File(filename);
    final todos = await Todo.readFile(file);

    switch (this) {
      case Action.create:
        if (content == null) {
          throw Exception('You have to specify a content.');
        }

        Todo.create(content, todos);
        Todo.writeFile(file, todos);

        return;
      case Action.delete:
        if (id == null) {
          throw Exception('You have to specify an id.');
        }

        Todo.delete(id, todos);
        Todo.writeFile(file, todos);

        return;
      case Action.list:
        for (final todo in todos) {
          // ignore: avoid_print
          print('${todo.id} - ${todo.content}');
        }
        return;
    }
  }
}
