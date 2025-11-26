import 'package:todo/core/core.dart';

class TodoEntity extends Equatable {
  final String todoId;
  final String title;
  final String endDateTime;
  final int isCompleted;
  final String createdAt;
  final String updatedAt;

  const TodoEntity({
    required this.todoId,
    required this.title,
    required this.endDateTime,
    required this.isCompleted,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  String toString() {
    return super.toString();
  }

  @override
  List<Object?> get props => [todoId, title, endDateTime, isCompleted, createdAt, updatedAt];
}
