/*

 TO DO VIEW: responsible for UI

 - use blocbuilder

*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_bloc/domain/models/todo.dart';
import 'package:todo_app_bloc/presentation/todo_cubit.dart';

class TodoView extends StatelessWidget {
  const TodoView({super.key});

  // show dialog box for user to type
  void _showAddTodoBox(BuildContext context) {
    final todoCubit = context.read<TodoCubit>();
    final textController = TextEditingController();

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: TextField(controller: textController),
              actions: [
                // cancel button
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Cancel'),
                ),

                //text button
                TextButton(
                  onPressed: () {
                    todoCubit.addTodo(textController.text);
                    Navigator.of(context).pop();
                  },
                  child: Text('Add'),
                ),
              ],
            ));
  }

// build UI
  @override
  Widget build(BuildContext context) {
    final todoCubit = context.read<TodoCubit>();
    // scaffold
    return Scaffold(
      // F A B
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _showAddTodoBox(context),
      ),

      // bloc builder
      body: BlocBuilder<TodoCubit, List<Todo>>(
        builder: (context, todos) {
          // list view
          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              // get individual todo from todos list
              final todo = todos[index];

              // List Tile UI
              return ListTile(
                // text
                title: Text(todo.text),

                // check box
                leading: Checkbox(
                  value: todo.isCompleted,
                  onChanged: (value) => todoCubit.toggleCompletion(todo),
                ),

                //delete button
                trailing: IconButton(
                    onPressed: () => todoCubit.deleteTodo(todo),
                    icon: Icon(Icons.cancel)),
              );
            },
          );
        },
      ),
    );

    // FAB
  }
}
