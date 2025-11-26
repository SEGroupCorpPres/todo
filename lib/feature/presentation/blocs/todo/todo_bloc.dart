import 'package:todo/core/core.dart';
import 'package:todo/feature/feature.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc({
    required AddTodo addTodo,
    required DeleteTodo removeTodo,
    required UpdateTodo updateTodo,
    required GetTodo getTodo,
    required GetTodos getTodos,
  }) : _addTodo = addTodo,
       _removeTodo = removeTodo,
       _updateTodo = updateTodo,
       _getTodo = getTodo,
       _getTodos = getTodos,
       super(InitialTodoState()) {
    on<AddTodoEvent>(_addTodoHandler);
    on<UpdateTodoEvent>(_updateTodoHandler);
    on<DeleteTodoEvent>(_removeTodoHandler);
    on<GetTodoEvent>(_getTodoHandler);
    on<GetTodosEvent>(_getTodosHandler);
  }

  final AddTodo _addTodo;
  final DeleteTodo _removeTodo;
  final UpdateTodo _updateTodo;
  final GetTodo _getTodo;
  final GetTodos _getTodos;

  Future<void> _addTodoHandler(AddTodoEvent event, Emitter<TodoState> emit) async {
    emit(LoadingTodoState());
    final result = await _addTodo(AddTodoParams(todo: event.todo));
    result.fold((failure) => emit(ErrorTodoState(error: failure.message)), (r) async {
      emit(CreateTodoState());
    });
  }

  Future<void> _removeTodoHandler(DeleteTodoEvent event, Emitter<TodoState> emit) async {
    emit(LoadingTodoState());
    final result = await _removeTodo(DeleteTodoParams(id: event.id));
    result.fold(
      (failure) => emit(ErrorTodoState(error: failure.message)),
      (_) => emit(DeleteTodoState()),
    );
  }

  Future<void> _updateTodoHandler(UpdateTodoEvent event, Emitter<TodoState> emit) async {
    emit(LoadingTodoState());
    final result = await _updateTodo(UpdateTodoParams(todo: event.todo));
    result.fold(
      (failure) => emit(ErrorTodoState(error: failure.message)),
      (_) => emit(UpdateTodoState()),
    );
  }

  Future<void> _getTodoHandler(GetTodoEvent event, Emitter<TodoState> emit) async {
    emit(LoadingTodoState());
    final result = await _getTodo(GetTodoParams(id: event.id));
    result.fold((failure) => emit(ErrorTodoState(error: failure.message)), (todo) {
      TodoModel todoModel = TodoModel.fromEntity(todo);
      emit(GetTodoState(todo: todoModel));
    });
  }

  Future<void> _getTodosHandler(GetTodosEvent event, Emitter<TodoState> emit) async {
    emit(LoadingTodoState());
    final result = await _getTodos();
    result.fold((failure) => emit(ErrorTodoState(error: failure.message)), (todos) {
      List<TodoModel>? todosData = todos?.map((todo) => TodoModel.fromEntity(todo)).toList();
      if (todosData != null) {
        emit(GetTodosState(todos: todosData));
      } else {
        emit(EmptyTodoState());
      }
    });
  }
}
