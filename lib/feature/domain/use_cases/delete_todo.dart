import 'package:todo/core/core.dart';
import 'package:todo/feature/domain/domain.dart';

class DeleteTodo extends UseCaseWithParams<bool, DeleteTodoParams> {
  final TodoRepository _repository;

  DeleteTodo(this._repository);

  @override
  ResultFuture<bool> call(DeleteTodoParams params) {
    return _repository.deleteTodoInLocalDB(id: params.id);
  }
}

class DeleteTodoParams extends Equatable {
  final String id;

  const DeleteTodoParams({required this.id});

  @override
  List<Object?> get props => [id];
}
