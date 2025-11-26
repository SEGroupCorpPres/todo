import 'package:todo/core/core.dart';
import 'package:todo/feature/domain/domain.dart';

class UpdateTodo extends UseCaseWithParams<bool, UpdateTodoParams> {
  final TodoRepository _repository;

  UpdateTodo(this._repository);

  @override
  ResultFuture<bool> call(UpdateTodoParams params) =>
      _repository.updateTodoInLocalDB(todo: params.todo);
}

class UpdateTodoParams extends Equatable {
  final TodoEntity todo;

  const UpdateTodoParams({required this.todo});

  @override
  List<Object?> get props => [todo];
}
