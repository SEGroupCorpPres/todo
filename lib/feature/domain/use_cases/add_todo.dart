import 'package:todo/core/core.dart';
import 'package:todo/feature/domain/domain.dart';

class AddTodo extends UseCaseWithParams<bool, AddTodoParams> {
  final TodoRepository _repository;

  AddTodo(this._repository);

  @override
  ResultFuture<bool> call(AddTodoParams params) => _repository.addTodoToLocalDB(todo: params.todo);
}

class AddTodoParams extends Equatable {
  final TodoEntity todo;

  const AddTodoParams({required this.todo});

  @override
  List<Object?> get props => [todo];
}
