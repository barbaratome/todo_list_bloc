import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_bloc/src/bloc/todos_bloc_event.dart';
import 'package:todo_list_bloc/src/views/todos_card.dart';

class TodosPage extends StatefulWidget {
  static const routeName = '/todos';
  const TodosPage({Key? key}) : super(key: key);

  @override
  State<TodosPage> createState() => _TodosPageState();
}

class _TodosPageState extends State<TodosPage> {
  final TextEditingController controller = TextEditingController();

  void addTodo(BuildContext context) {
    if (controller.text.isEmpty) return;
    final TodoBloc bloc = context.read<TodoBloc>();
    final Todo todo = Todo.initialize(text: controller.text);
    bloc.add(TodoEvent(Type.add, todo));
    controller.clear();
  }

  Future<void> _displayDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Adicionar nova tarefa'),
          content: TextField(
            controller: controller,
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Salvar'),
              onPressed: () {
                Navigator.of(context).pop();
                addTodo(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 159, 82, 107),
      body: BlocBuilder<TodoBloc, List<Todo>>(
        builder: (context, todos) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 80.0,
                      width: double.infinity,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Text(
                            'Tarefas  ',
                            style: TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                          CircleAvatar(
                            backgroundColor:
                                const Color.fromARGB(255, 247, 230, 235),
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.list,
                                color: Color.fromARGB(255, 159, 82, 107),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      topRight: Radius.circular(15.0),
                    ),
                  ),
                  child: ListView(
                    children:
                        todos.map((todo) => TodoCard(todo: todo)).toList(),
                  ),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FloatingActionButton(
          elevation: 5,
          backgroundColor: const Color.fromARGB(255, 159, 82, 107),
          hoverColor: Colors.white70,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          onPressed: () => _displayDialog(),
          child: const Icon(Icons.add, color: Colors.white,),
        ),
      ),
    );
  }
}
