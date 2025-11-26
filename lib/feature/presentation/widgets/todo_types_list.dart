import 'package:todo/core/core.dart';
import 'package:todo/feature/presentation/presentation.dart';

class TodoTypesList extends StatefulWidget {
  const TodoTypesList({super.key, required this.type});

  final String type;

  @override
  State<TodoTypesList> createState() => _TodoTypesListState();
}

class _TodoTypesListState extends State<TodoTypesList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        if (state is LoadingTodoState) {
          return const LoadingView();
        }
        if (state is GetTodosState) {
          return Column(
            children: [
              Container(
                margin: .symmetric(horizontal: 15.w, vertical: 10.h),
                child: ShadowedContainer(
                  child: BlocBuilder<ExpansionTileCubit, ExpansionTileState>(
                    builder: (context, expansionState) {
                      return ListTile(
                        onTap: () {
                          switch (widget.type) {
                            case AppConstants.inWork:
                              context.read<ExpansionTileCubit>().toggleInWork();
                              break;
                            case AppConstants.underReview:
                              context.read<ExpansionTileCubit>().toggleUnderReview();
                              break;
                            case AppConstants.done:
                              context.read<ExpansionTileCubit>().toggleDone();
                              break;
                            default:
                              context.read<ExpansionTileCubit>().toggleTobeCompleted();
                              break;
                          }
                        },
                        title: Row(
                          mainAxisAlignment: .spaceBetween,
                          children: [
                            Text(widget.type),
                            Padding(
                              padding: .only(right: 30.w),
                              child: Text(
                                filterTodoList(state.todos!, widget.type).length.toString(),
                              ),
                            ),
                          ],
                        ),
                        trailing: getIcon(widget.type, expansionState),
                      );
                    },
                  ),
                ),
              ),
              BlocBuilder<ExpansionTileCubit, ExpansionTileState>(
                builder: (context, expansionState) {
                  switch (widget.type) {
                    case AppConstants.inWork:
                      return expansionState.isExpandedInWork
                          ? AnimatedTodoList(todos: state.todos, filter: AppConstants.inWork)
                          : const SizedBox();
                    case AppConstants.underReview:
                      return expansionState.isExpandedUnderReview
                          ? AnimatedTodoList(todos: state.todos, filter: AppConstants.underReview)
                          : const SizedBox();
                    case AppConstants.done:
                      return expansionState.isExpandedDone
                          ? AnimatedTodoList(todos: state.todos, filter: AppConstants.done)
                          : const SizedBox();
                    default:
                      return expansionState.isExpandedTobeCompleted
                          ? AnimatedTodoList(todos: state.todos, filter: AppConstants.toBeCompleted)
                          : const SizedBox();
                  }
                },
              ),
            ],
          );
        }
        if (state is ErrorTodoState) {
          return CustomErrorWidget(error: state.error);
        }
        if (state is EmptyTodoState) {
          return const Center(child: Text('No data'));
        }
        return const SizedBox();
      },
    );
  }
}

Widget getIcon(String type, ExpansionTileState state) {
  switch (type) {
    case AppConstants.inWork:
      return InWorkChevronIcon(state: state);
    case AppConstants.underReview:
      return UnderReviewChevronIcon(state: state);
    case AppConstants.done:
      return DoneChevronIcon(state: state);
    default:
      return TobeChevronIcon(state: state);
  }
}

class TobeChevronIcon extends StatelessWidget {
  const TobeChevronIcon({super.key, required this.state});

  final ExpansionTileState state;

  @override
  Widget build(BuildContext context) {
    return Icon(
      state.isExpandedTobeCompleted ? CupertinoIcons.chevron_up : CupertinoIcons.chevron_down,
    );
  }
}

class InWorkChevronIcon extends StatelessWidget {
  const InWorkChevronIcon({super.key, required this.state});

  final ExpansionTileState state;

  @override
  Widget build(BuildContext context) {
    return Icon(state.isExpandedInWork ? CupertinoIcons.chevron_up : CupertinoIcons.chevron_down);
  }
}

class UnderReviewChevronIcon extends StatelessWidget {
  const UnderReviewChevronIcon({super.key, required this.state});

  final ExpansionTileState state;

  @override
  Widget build(BuildContext context) {
    return Icon(
      state.isExpandedUnderReview ? CupertinoIcons.chevron_up : CupertinoIcons.chevron_down,
    );
  }
}

class DoneChevronIcon extends StatelessWidget {
  const DoneChevronIcon({super.key, required this.state});

  final ExpansionTileState state;

  @override
  Widget build(BuildContext context) {
    return Icon(state.isExpandedDone ? CupertinoIcons.chevron_up : CupertinoIcons.chevron_down);
  }
}
