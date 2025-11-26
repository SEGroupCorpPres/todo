import 'package:todo/core/core.dart';
import 'package:todo/feature/feature.dart';

class TodoRepositoryImpl implements TodoRepository {
  TodoRepositoryImpl(this._localDataSource);

  final TodoLocalDataSource _localDataSource;

  @override
  ResultFuture<bool> addTodoToLocalDB({required TodoEntity todo}) async {
    try {
      TodoModel todoModel = TodoModel.fromEntity(todo);
      await _localDataSource.insertTodo(todoModel);
      return Right(true);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  ResultFuture<bool> deleteTodoInLocalDB({required String id}) async {
    try {
      await _localDataSource.deleteTodo(id);
      return Right(true);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  ResultFuture<TodoEntity> getTodoFromLocalDB({required String id}) async {
    try {
      final localResult = await _localDataSource.getTodo(id);
      return Right(localResult!);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  ResultFuture<List<TodoEntity>?> getTodosListFromLocalDB() async {
    try {
      final localResult = await _localDataSource.getAllTodos();
      return Right(localResult);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  ResultFuture<bool> updateTodoInLocalDB({required TodoEntity todo}) async {
    try {
      TodoModel todoModel = TodoModel.fromEntity(todo);

      await _localDataSource.updateTodo(todoModel);
      return Right(true);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }
}
