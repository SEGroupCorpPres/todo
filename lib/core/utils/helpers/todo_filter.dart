import 'package:todo/core/core.dart';
import 'package:todo/feature/data/data.dart';

List<TodoModel> filterTodoList(List<TodoModel> todos, String filter) {
  switch (filter) {
    case AppConstants.inWork:
      return todos
          .where(
            (todo) =>
                (DateTime.parse(todo.endDateTime)).millisecondsSinceEpoch >
                DateTime.now().millisecondsSinceEpoch,
          )
          .toList();
    case AppConstants.underReview:
      return todos
          .where(
            (todo) =>
                (DateTime.parse(todo.endDateTime)).millisecondsSinceEpoch <
                    DateTime.now().millisecondsSinceEpoch &&
                todo.isCompleted == 0,
          )
          .toList();
    case AppConstants.done:
      return todos.where((todo) => todo.isCompleted == 1).toList();
    default:
      return todos
          .where(
            (todo) =>
                (DateTime.parse(todo.endDateTime)).millisecondsSinceEpoch ==
                    DateTime.now().millisecondsSinceEpoch &&
                todo.isCompleted == 0,
          )
          .toList();
  }
}
