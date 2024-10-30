/*

 DATABASE REPO

 this implement the todo repo and handels string, retrieving, updating, 
 deleting in the isar database

*/

import 'package:isar/isar.dart';
import 'package:todo_app_bloc/data/models/isar_todo.dart';
import 'package:todo_app_bloc/domain/models/todo.dart';
import 'package:todo_app_bloc/domain/repository/todo_repo.dart';

class IsarTodoRepo implements TodoRepo {
  // database
  final Isar db;

  IsarTodoRepo(this.db);

  // get todos
  @override
  Future<List<Todo>> getTodos() async {
    // fetch from db
    final todos = await db.toDoIsars.where().findAll();

    // return as a list of todos and give to domain layer
    return todos.map((ToDoIsar) => ToDoIsar.toDomain()).toList();
  }

  // add todo
  @override
  Future<void> addTodo(Todo newTodo) async {
    // convert todo into isar todo
    final todoIsar = ToDoIsar.fromDomain(newTodo);

    // do that we can store it in our isar db
    return db.writeTxn(() => db.toDoIsars.put(todoIsar));
  }

  //update todo
  @override
  Future<void> updateTodo(Todo todo) {
    // convert todo into isar todo
    final todoIsar = ToDoIsar.fromDomain(todo);

    // do that we can store it in our isar db
    return db.writeTxn(() => db.toDoIsars.put(todoIsar));
  }

  //delete todo
  @override
  Future<void> deleteTodo(Todo todo) async {
    await db.writeTxn(
      () => db.toDoIsars.delete(todo.id),
    );
  }
}
