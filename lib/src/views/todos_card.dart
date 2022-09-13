import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_bloc/src/bloc/todos_bloc_event.dart';

class TodoCard extends StatelessWidget {
  final Color? color;
  final Todo todo;

  TodoCard({required this.todo, this.color, key}) : super(key: key);

  final TextEditingController controller = TextEditingController();

  deleteTodo(BuildContext context) {
    final bloc = context.read<TodoBloc>();
    bloc.add(TodoEvent(Type.remove, todo));
  }

  editTodo(BuildContext context) {
    controller.text = todo.text;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Editar'),
          content: TextField(controller: controller, maxLines: null),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () => updateTodo(context),
              child: const Text('Savar'),
            )
          ],
        );
      },
    );
  }

  updateTodo(BuildContext context) {
    if (controller.text.isEmpty) return;
    final bloc = context.read<TodoBloc>();
    bloc.add(TodoEvent(Type.update, todo.copyWith(text: controller.text)));
    Navigator.pop(context);
  }

  completeTodo(BuildContext context) {
    final bloc = context.read<TodoBloc>();
    bloc.add(
      TodoEvent(Type.update, todo.copyWith(isCompleted: !todo.isCompleted)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final hexCode = int.parse('0xff${todo.id.substring(0, 6)}');

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Color(hexCode).withOpacity(0.1),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        children: [
          Checkbox(
            value: todo.isCompleted,
            onChanged: (_) => completeTodo(context),
          ),
          Expanded(
            child: Text(
              todo.text,
              style: TextStyle(
                decoration: todo.isCompleted
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
          ),
          IconButton(
            onPressed: () => editTodo(context),
            icon: const Icon(Icons.edit_outlined, color: Color.fromARGB(255, 159, 82, 107),),
          ),
          IconButton(
            onPressed: () => deleteTodo(context),
            icon: const Icon(Icons.delete_outlined, color: Color.fromARGB(255, 159, 82, 107),
            ),
          ), 
        ],
      ), 
    ); 
  }
}
