part of 'todo_bloc.dart';

abstract class TodoState extends Equatable {
  const TodoState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class InitialTodoState extends TodoState {
  const InitialTodoState();
}

class GetTodoState extends TodoState {
  final TodoModel todo;

  const GetTodoState({required this.todo});

  @override
  List<Object?> get props => [todo];
}

class GetTodosState extends TodoState {
  final List<TodoModel>? todos;

  const GetTodosState({required this.todos});

  @override
  List<Object?> get props => [todos];
}

class UpdateTodoState extends TodoState {
  const UpdateTodoState();
}

class DeleteTodoState extends TodoState {
  const DeleteTodoState();
}

class CreateTodoState extends TodoState {
  const CreateTodoState();
}

class ErrorTodoState extends TodoState {
  final String error;

  const ErrorTodoState({required this.error});

  @override
  List<Object?> get props => [error];
}

class LoadingTodoState extends TodoState {
  const LoadingTodoState();
}

class TodoSuccessState extends TodoState {
  const TodoSuccessState();
}

class EmptyTodoState extends TodoState {
  const EmptyTodoState();
}
