import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_2/view_models/app_state_view_model.dart';

class AddTaskForm extends StatefulWidget {
  const AddTaskForm({super.key});

  @override
  State<AddTaskForm> createState() => _AddTaskFormState();
}

class _AddTaskFormState extends State<AddTaskForm> {
  final TextEditingController _controller = TextEditingController();

  void _submit(BuildContext context) {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      _controller.clear();
      context.read<AppStateViewModel>().addTodo(text);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: "Add a new task",
                filled: true,
                fillColor: Colors.grey.shade100,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          ElevatedButton(
            onPressed: () => _submit(context),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
