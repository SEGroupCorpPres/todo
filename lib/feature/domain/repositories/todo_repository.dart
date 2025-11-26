import 'package:todo/core/core.dart';
import 'package:todo/feature/domain/domain.dart';

abstract class TodoRepository {
  ResultFuture<TodoEntity> getTodoFromLocalDB({required String id});

  ResultFuture<List<TodoEntity>?> getTodosListFromLocalDB();

  ResultFuture<bool> addTodoToLocalDB({required TodoEntity todo});

  ResultFuture<bool> updateTodoInLocalDB({required TodoEntity todo});

  ResultFuture<bool> deleteTodoInLocalDB({required String id});
}
