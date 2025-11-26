import 'package:todo/core/core.dart';
import 'package:todo/feature/domain/domain.dart';

class GetTodos extends UseCaseWithoutParams<List<TodoEntity>?> {
  final TodoRepository _repository;

  GetTodos(this._repository);

  @override
  ResultFuture<List<TodoEntity>?> call() {
    return _repository.getTodosListFromLocalDB();
  }
}
