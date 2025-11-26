part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object?> get props => [];
}

class InitTodo extends TodoEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AddTodoEvent extends TodoEvent {
  final TodoModel todo;

  const AddTodoEvent({required this.todo});

  @override
  // TODO: implement props
  List<Object?> get props => [todo];
}

class DeleteTodoEvent extends TodoEvent {
  final String id;

  const DeleteTodoEvent({required this.id});

  @override
  // TODO: implement props
  List<Object?> get props => [id];
}

class UpdateTodoEvent extends TodoEvent {
  final TodoModel todo;

  const UpdateTodoEvent({required this.todo});

  @override
  // TODO: implement props
  List<Object?> get props => [todo];
}

class GetTodoEvent extends TodoEvent {
  final String id;

  const GetTodoEvent({required this.id});

  @override
  // TODO: implement props
  List<Object?> get props => [id];
}

class GetTodosEvent extends TodoEvent {
  const GetTodosEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ErrorTodoEvent extends TodoEvent {
  final String message;

  const ErrorTodoEvent({required this.message});

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
