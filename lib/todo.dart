// ignore_for_file: avoid_dynamic_calls

import 'dart:convert';
import 'dart:io';

class Todo {
  Todo(this.id, this.content, this.date);

  late int id;
  late String content;
  late String date;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    data['id'] = id;
    data['content'] = content;
    data['date'] = date;

    return data;
  }

  static void create(String content, List<Todo> todos) {
    todos.add(
      Todo(
        todos.length + 1,
        content,
        DateTime.now().toIso8601String(),
      ),
    );
  }

  static void delete(int id, List<Todo> todos) {
    todos.remove(todos.where((todo) => todo.id == id).first);
  }

  static Future<List<Todo>> readFile(File file) async {
    final content = await file.readAsString();
    final json = jsonDecode(content) as List<dynamic>;

    final todos = json.map((dynamic todo) {
      return Todo(
        todo['id'] as int,
        todo['content'] as String,
        todo['date'] as String,
      );
    });

    return todos.map((e) => Todo(e.id, e.content, e.date)).toList();
  }

  static void writeFile(File file, List<Todo> todos) {
    file.writeAsStringSync(
      json.encode(todos.map((todo) => todo.toJson()).toList()),
    );
  }
}
