import 'package:todo/core/core.dart';
import 'package:todo/feature/feature.dart';

class AnimatedTodoList extends StatefulWidget {
  const AnimatedTodoList({super.key, this.todos, required this.filter});

  final List<TodoModel>? todos;
  final String filter;

  @override
  State<AnimatedTodoList> createState() => _AnimatedTodoListState();
}

enum TodoActionType { done, delete }

class _AnimatedTodoListState extends State<AnimatedTodoList> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return Padding(
      padding: .symmetric(horizontal: 15.w),
      child: AnimationLimiter(
        child: ListView.separated(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          itemCount: filterTodoList(widget.todos!, widget.filter).length,
          separatorBuilder: (context, index) => SizedBox(height: 10),
          itemBuilder: (BuildContext context, int index) {
            TodoModel todo = filterTodoList(widget.todos!, widget.filter)[index];
            return AnimationConfiguration.staggeredList(
              position: index,
              delay: Duration(milliseconds: 100),
              child: SlideAnimation(
                duration: Duration(milliseconds: 2500),
                curve: Curves.fastLinearToSlowEaseIn,
                verticalOffset: -250,
                child: ScaleAnimation(
                  duration: Duration(milliseconds: 1500),
                  curve: Curves.fastLinearToSlowEaseIn,
                  child: ShadowedContainer(
                    child: GestureDetector(
                      onHorizontalDragEnd: (DragEndDetails details) {
                        final velocity = details.velocity.pixelsPerSecond.dx;

                        if (velocity > 300) {
                          // Swipe right → Done
                          showChangeTodoStatus(
                            context,
                            todo,
                            size,
                            actionType: TodoActionType.done,
                          );
                        } else if (velocity < -300) {
                          // Swipe left → Delete
                          showChangeTodoStatus(
                            context,
                            todo,
                            size,
                            actionType: TodoActionType.delete,
                          );
                        }
                      },
                      child: ListTile(
                        title: Container(
                          margin: .only(bottom: 10.h),
                          child: Text(todo.title),
                        ),
                        subtitle: Row(
                          mainAxisAlignment: .spaceBetween,
                          crossAxisAlignment: .center,
                          children: [
                            Row(
                              spacing: 10,
                              children: [
                                Icon(Icons.calendar_today),
                                Text(getDate(todo.endDateTime)),
                              ],
                            ),
                            if (widget.filter == AppConstants.underReview)
                              Container(
                                padding: .symmetric(horizontal: 10.w, vertical: 5.h),
                                decoration: BoxDecoration(
                                  color: Colors.red.shade400,
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Text(
                                  AppConstants.expired,
                                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                                    color: Colors.white,
                                    fontSize: 13.sp,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _handleTodoAction(BuildContext context, TodoModel todo, TodoActionType actionType) {
    final bloc = context.read<TodoBloc>();

    if (actionType == TodoActionType.done) {
      bloc.add(UpdateTodoEvent(todo: todo.copyWith(isCompleted: 1)));
    } else {
      bloc.add(DeleteTodoEvent(id: todo.todoId));
    }

    bloc.add(GetTodosEvent());
    context.pop();
  }

  void showChangeTodoStatus(
    BuildContext context,
    TodoModel todo,
    Size size, {
    required TodoActionType actionType,
  }) {
    showAdaptiveDialog(
      context: context,
      builder: (_) => AlertDialog.adaptive(
        constraints: BoxConstraints(maxWidth: size.width * 0.8, maxHeight: size.height * 0.8),
        title: Text(AppConstants.editWarning),
        actions: [
          Platform.isIOS
              ? CupertinoActionSheetAction(
                  onPressed: () => context.pop(),
                  child: Text(AppConstants.cancel),
                )
              : TextButton(onPressed: () => context.pop(), child: Text(AppConstants.cancel)),
          Platform.isIOS
              ? CupertinoActionSheetAction(
                  onPressed: () => _handleTodoAction(context, todo, actionType),
                  isDefaultAction: actionType == TodoActionType.done,
                  isDestructiveAction: actionType == TodoActionType.delete,
                  child: Text(
                    actionType == TodoActionType.done ? AppConstants.done : AppConstants.delete,
                  ),
                )
              : TextButton(
                  onPressed: () => _handleTodoAction(context, todo, actionType),
                  child: Text(
                    actionType == TodoActionType.done ? AppConstants.done : AppConstants.delete,
                  ),
                ),
        ],
      ),
    );
  }
}
