import 'package:flutter/material.dart';
import 'package:todo_list_bloc/src/views/todo_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/images/splashscreen.jpg'),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Todo List',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 159, 82, 107),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (contex) => const TodosPage()));
            },
            icon: const Icon(Icons.arrow_right),
            label: const Text('Começar'),
          )
        ],
      ),
    );
  }
}
