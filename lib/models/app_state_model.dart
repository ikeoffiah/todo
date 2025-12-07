import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_2/models/todo_model.dart';

part 'app_state_model.freezed.dart';

@freezed
abstract class AppState with _$AppState {
  const factory AppState({required List<Todo> todos}) = _AppState;
}
