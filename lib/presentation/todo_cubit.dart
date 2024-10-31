/*
 
 TO DO CUBIT - simple state management

 Each cubit is a list of todos.

*/

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_bloc/domain/models/todo.dart';
import 'package:todo_app_bloc/domain/repository/todo_repo.dart';

class TodoCubit extends Cubit<List<Todo>> {
  // reference todo repo
  final TodoRepo todoRepo;

  // constructor initialize the with an empty list
  TodoCubit(this.todoRepo) : super([]) {
    loadTodos();
  }

  //  L O A D
  Future<void> loadTodos() async {
    // fetch list of todos from repo
    final todoList = await todoRepo.getTodos();

    // emit the fetched list as the new state
    emit(todoList);
  }

  // A D D
  Future<void> addTodo(String text) async {
    // create a new todo with unique ID
    final newTodo = Todo(id: DateTime.now().millisecondsSinceEpoch, text: text);

    // save the new todo to repo
    await todoRepo.addTodo(newTodo);

    // reload
    loadTodos();
  }

  // D E L E T E
  Future<void> deleteTodo(Todo todo) async {
    // delete the provided todo from repo

    // reload
    loadTodos();
  }

  // T O G G L E
  Future<void> toggleCompletion(Todo todo) async {
    // toogle the completion status of provideer todo
    final updateTodo = todo.toggleCompletion();

    // update the todo in repo with new completion status
    await todoRepo.updateTodo(updateTodo);

    //reload
    loadTodos();
  }
}
