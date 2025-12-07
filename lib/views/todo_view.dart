import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_2/models/todo_model.dart';
import 'package:test_2/view_models/app_state_view_model.dart';
import 'package:test_2/views/custom_widget/add_task_form.dart';
import 'package:test_2/views/custom_widget/todo_card.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo App')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: const AddTaskForm(),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Selector<AppStateViewModel, int>(
              selector: (context, vm) => vm.completedTodosCount,
              builder: (context, count, _) {
                return Text('Completed Tasks: $count');
              },
            ),
            Selector<AppStateViewModel, int>(
              selector: (context, vm) => vm.appState.todos.length,
              builder: (context, todosCount, _) {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: todosCount,
                  itemBuilder: (context, index) {
                    return Selector<AppStateViewModel, Todo>(
                      selector: (context, vm) => vm.appState.todos[index],
                      builder: (context, todo, _) {
                        return TodoCard(
                          key: ValueKey(todo.id),
                          task: todo.task,
                          completed: todo.completed,
                          index: index,
                        );
                      },
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
