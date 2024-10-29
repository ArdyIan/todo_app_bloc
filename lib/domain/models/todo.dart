/*
 
TO DO MODEL

--------------------------------------------------------------
 
It has these propertiese

- id
- text
- isCompleted

--------------------------------------------------------------

Methods:
- toggle complete on & off

*/

class Todo {
  final int id;
  final String text;
  final bool isCompleted;

  Todo({
    required this.id,
    required this.text,
    this.isCompleted = false, //initiali, todo is incomplete
  });

  Todo toggleCompletion() {
    return Todo(id: id, text: text, isCompleted: !isCompleted);
  }
}
