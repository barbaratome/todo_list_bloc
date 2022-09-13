import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/todo.dart';

export '../models/todo.dart';

enum Type { add, remove, update }

class TodoEvent {
  final Type type;
  final Todo todo;

  const TodoEvent(this.type, this.todo);
}

 List<Todo> fakeTodos = [];


class TodoBloc extends Bloc<TodoEvent, List<Todo>> {
  TodoBloc() : super(fakeTodos) {
    on(addEvent);
  }

  void addEvent(TodoEvent event, emit) {
    final List<Todo> todos = state; 
    final Todo todo = event.todo;

    switch (event.type) {
      case Type.add:
        todos.add(todo);
        emit(List<Todo>.from(todos));
        break;
      case Type.remove:
        todos.remove(todo);
        emit(List<Todo>.from(todos));
        break;
      case Type.update:
        final index = todos.indexOf(todo);
        todos[index] = todo;
        emit(List<Todo>.from(todos));
        break;
    }
  }
}
