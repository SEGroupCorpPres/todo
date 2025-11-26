import 'package:todo/core/core.dart';
import 'package:todo/feature/data/data.dart';

abstract class TodoLocalDataSource {
  Future<void> insertTodo(TodoModel todo);

  Future<TodoModel?> getTodo(String todoId);

  Future<List<TodoModel>> getAllTodos();

  Future<void> updateTodo(TodoModel todo);

  Future<void> deleteTodo(String todoId);
}
