import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_2/view_models/app_state_view_model.dart';

class TodoCard extends StatelessWidget {
  const TodoCard({
    super.key,
    required this.task,
    required this.completed,
    required this.index,
  });

  final String task;
  final bool completed;
  final int index;  

void toggleTodo(BuildContext context) {
  context.read<AppStateViewModel>().toggleTodo(index);
}

void removeTodo(BuildContext context) {
  context.read<AppStateViewModel>().removeTodo(index);
}

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Checkbox(
              value: completed,
              onChanged: (value) {
                toggleTodo(context);
              },
              activeColor: Colors.blueAccent,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                task,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  decoration: completed ? TextDecoration.lineThrough : null,
                  color: completed ? Colors.grey : Colors.black87,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                toggleTodo(context);
              },
              child: Icon(
                completed ? Icons.check_circle : Icons.circle_outlined,
                color: completed ? Colors.green : Colors.grey,
                
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              color: Colors.red,
              onPressed: () {
                removeTodo(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
