import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_2/view_models/app_state_view_model.dart';
import 'package:test_2/views/todo_view.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppStateViewModel(),
      child: const MyApp(),
    )
    );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const TodoScreen(),
    );
  }
}

