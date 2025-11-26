import 'package:todo/core/core.dart';
import 'package:todo/feature/domain/domain.dart';

class TodoModel extends TodoEntity {
  const TodoModel({
    required super.todoId,
    required super.title,
    required super.endDateTime,
    required super.isCompleted,
    required super.createdAt,
    required super.updatedAt,
  });

  TodoModel.fromMap(DataMap map)
    : super(
        todoId: map['id'] as String,
        title: map['title'] as String,
        endDateTime: map['end_date_time'] as String,
        isCompleted: map['is_completed'] as int,
        createdAt: map['created_at'] as String,
        updatedAt: map['updated_at'] as String,
      );

  DataMap toMap() => {
    'id': todoId,
    'title': title,
    'end_date_time': endDateTime,
    'is_completed': isCompleted,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };

  TodoModel copyWith({
    String? todoId,
    String? title,
    String? endDateTime,
    int? isCompleted,
    String? createdAt,
    String? updatedAt,
  }) => TodoModel(
    todoId: todoId ?? this.todoId,
    title: title ?? this.title,
    endDateTime: endDateTime ?? this.endDateTime,
    isCompleted: isCompleted ?? this.isCompleted,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  factory TodoModel.fromEntity(TodoEntity entity) => TodoModel(
    todoId: entity.todoId,
    title: entity.title,
    endDateTime: entity.endDateTime,
    isCompleted: entity.isCompleted,
    createdAt: entity.createdAt,
    updatedAt: entity.updatedAt,
  );

  TodoEntity toEntity() => TodoEntity(
    todoId: todoId,
    title: title,
    endDateTime: endDateTime,
    isCompleted: isCompleted,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );

  TodoModel.empty()
    : this(
        todoId: '',
        title: '',
        endDateTime: '',
        isCompleted: 0,
        createdAt: DateTime.now().toIso8601String(),
        updatedAt: DateTime.now().toIso8601String(),
      );

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [todoId, title, endDateTime, isCompleted, createdAt, updatedAt];
}
