import 'package:freezed_annotation/freezed_annotation.dart';
part 'todo_model.freezed.dart';

@freezed
abstract class Todo with _$Todo {
  const factory Todo({
    required String id,
    required String task,
    required bool completed,
  }) = _Todo;
}