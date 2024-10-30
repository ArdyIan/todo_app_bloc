/*

ISAR TO DO MODEL

convert todo model into isar todo modeel that we store in our isar db

*/

import 'package:isar/isar.dart';
import 'package:todo_app_bloc/domain/models/todo.dart';

// to generate isar todo object ,run: dart run build_runner build
part 'isar_todo.g.dart';

@collection
class ToDoIsar {
  Id id = Isar.autoIncrement;
  late String text;
  late bool isCompleted;

  // convert isar object -> pure todo object to use in our app
  Todo toDomain() {
    return Todo(
      id: id,
      text: text,
      isCompleted: !isCompleted,
    );
  }

  // convert pure to do object -> isar object to store in isar db
  static ToDoIsar fromDomain(Todo todo) {
    return ToDoIsar()
      ..id = todo.id
      ..text = todo.text
      ..isCompleted = todo.isCompleted;
  }
}
