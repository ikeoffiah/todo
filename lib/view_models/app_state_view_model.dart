import 'package:flutter/material.dart';
import 'package:test_2/models/app_state_model.dart';
import 'package:test_2/models/todo_model.dart';

class AppStateViewModel extends ChangeNotifier {
  AppState _appState = AppState(todos: []);

  AppState get appState => _appState;

  int get completedTodosCount =>
      _appState.todos.where((t) => t.completed).length;

  void addTodo(String task) {
    final newTodo = Todo(task: task, completed: false, id: '${DateTime.now().millisecondsSinceEpoch}_${DateTime.now().microsecond}');
    _appState = _appState.copyWith(todos: [..._appState.todos, newTodo]);
    notifyListeners();
  }

  void removeTodo(int index) {
    final todos = List<Todo>.from(_appState.todos);
    todos.removeAt(index);
    _appState = _appState.copyWith(todos: todos);
    notifyListeners();
  }

  void toggleTodo(int index) {
    final todos = List<Todo>.from(_appState.todos);
    todos[index] = todos[index].copyWith(completed: !todos[index].completed);
    _appState = _appState.copyWith(todos: todos);
    notifyListeners();
  }
}
