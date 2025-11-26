import 'package:todo/core/core.dart';
import 'package:todo/feature/domain/domain.dart';

class GetTodo extends UseCaseWithParams<TodoEntity, GetTodoParams> {
  final TodoRepository _repository;

  GetTodo(this._repository);

  @override
  ResultFuture<TodoEntity> call(GetTodoParams params) =>
      _repository.getTodoFromLocalDB(id: params.id);
}

class GetTodoParams extends Equatable {
  final String id;

  const GetTodoParams({required this.id});

  @override
  List<Object?> get props => [id];
}
