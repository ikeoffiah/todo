## Why only the minimum widgets rebuild

I use Provider’s selection APIs (`Selector` and `context.select`) to ensure widgets only rebuild when the specific data they depend on changes.

- **[Completed count selection]** [lib/views/todo_view.dart](cci:7://file:///Users/pius/Documents/bmoni_test_2/test_2/lib/views/todo_view.dart:0:0-0:0):
  - `Selector<AppStateViewModel, int>(selector: (context, vm) => vm.completedTodosCount, ...)`
  - Depends only on a primitive `int` derived from `todos`. Only the count [Text](cci:1://file:///Users/pius/Documents/bmoni_test_2/test_2/lib/views/custom_widget/todo_card.dart:0:14-8:15) rebuilds when the computed value changes.

- **[List length selection]** [lib/views/todo_view.dart](cci:7://file:///Users/pius/Documents/bmoni_test_2/test_2/lib/views/todo_view.dart:0:0-0:0):
  - `Selector<AppStateViewModel, int>(selector: (context, vm) => vm.appState.todos.length, ...)`
  - The ListView container rebuilds only when the length changes (add/remove). Toggling a todo’s `completed` flag does not change length, so the container does not rebuild.

- **[Per-row selection]** [lib/views/todo_view.dart](cci:7://file:///Users/pius/Documents/bmoni_test_2/test_2/lib/views/todo_view.dart:0:0-0:0):
  - Each row is wrapped with `Selector<AppStateViewModel, Todo>(selector: (context, vm) => vm.appState.todos[index], ...)`
  - Only the row whose [Todo](cci:2://file:///Users/pius/Documents/bmoni_test_2/test_2/lib/models/todo_model.dart:3:0-10:1) instance changes rebuilds (e.g., when its `completed` flips).
  - Rows are keyed with `ValueKey(todo.id)`, preserving identity across insert/remove operations and minimizing row re-mounting.

- **[Stateless item + non-listening actions]** [lib/views/custom_widget/todo_card.dart](cci:7://file:///Users/pius/Documents/bmoni_test_2/test_2/lib/views/custom_widget/todo_card.dart:0:0-0:0):
  - [TodoCard](cci:2://file:///Users/pius/Documents/bmoni_test_2/test_2/lib/views/custom_widget/todo_card.dart:4:0-77:1) is stateless and receives primitive props (`task`, `completed`).
  - Actions use `context.read<AppStateViewModel>()`, which does not listen, so dispatching actions does not trigger rebuilds.

- **[Derived, not duplicated state]** [lib/view_models/app_state_view_model.dart](cci:7://file:///Users/pius/Documents/bmoni_test_2/test_2/lib/view_models/app_state_view_model.dart:0:0-0:0):
  - `completedTodosCount` is a getter derived from `todos` instead of a manually maintained counter, preventing drift and extra rebuilds.

Together, these choices ensure only the smallest necessary subtree rebuilds:
- The count text when the computed count changes.
- The list container only when length changes.
- The specific [TodoCard](cci:2://file:///Users/pius/Documents/bmoni_test_2/test_2/lib/views/custom_widget/todo_card.dart:4:0-77:1) whose data changed.