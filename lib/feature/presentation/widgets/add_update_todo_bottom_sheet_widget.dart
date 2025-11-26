import 'package:todo/core/core.dart';
import 'package:todo/feature/data/data.dart';
import 'package:todo/feature/presentation/presentation.dart';

class AddUpdateTodoBottomSheetWidget extends StatefulWidget {
  const AddUpdateTodoBottomSheetWidget({super.key});

  @override
  State<AddUpdateTodoBottomSheetWidget> createState() =>
      _AddUpdateTodoBottomSheetWidgetState();
}

class _AddUpdateTodoBottomSheetWidgetState
    extends State<AddUpdateTodoBottomSheetWidget> {
  late TextEditingController _titleController;
  late TextEditingController _dateController;

  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _saveTodo(BuildContext context) async {
    try {
      if (_formKey.currentState!.validate()) {
        final selectedDate = context.read<DateCubit>().state.selectedDate;
        if (selectedDate == null) {
          // Optionally, show an error to the user to select a date.
          log("Date not selected");
          return;
        }

        TodoModel todo = TodoModel(
          todoId: DateTime.now().microsecondsSinceEpoch.toString(),
          title: _titleController.text,
          endDateTime: selectedDate.toIso8601String(),
          isCompleted: 0,
          createdAt: DateTime.now().toIso8601String(),
          updatedAt: DateTime.now().toIso8601String(),
        );
        context.read<TodoBloc>().add(AddTodoEvent(todo: todo));
        context.read<TodoBloc>().add(GetTodosEvent());
        context.pop(); // Pop only after a successful save
      }
    } catch (e) {
      log(e.toString());
      // Optionally, show a user-facing error message
    }
  }

  Future<void> _buildCupertinoDatePicker(BuildContext context) async {
    await showModalBottomSheet(
      builder: (context) => const CupertinoDataPickerWidget(),
      context: context,
    );
  }

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _dateController = TextEditingController();

  }

  @override
  void dispose() {
    _titleController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final initialDate = context.read<DateCubit>().state.selectedDate;
    if (initialDate != null) {
      _dateController.text = _dateFormat.format(initialDate);
    }
    return Container(
      width: MediaQuery.sizeOf(context).width,
      padding: .all(16),
      child: Column(
        mainAxisSize: .min,
        children: [
          Row(
            mainAxisAlignment: .spaceBetween,
            crossAxisAlignment: .center,
            children: [
              Text(AppConstants.createdTodo,
                  style: Theme.of(context).appBarTheme.titleTextStyle),
              IconButton(
                onPressed: () => context.pop(),
                style: Theme.of(
                  context,
                ).iconButtonTheme.style!.copyWith(
                    backgroundColor: WidgetStateColor.transparent),
                icon: const Icon(Icons.close, color: Colors.black),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .copyWith(color: Colors.black),
                  decoration: InputDecoration(labelText: AppConstants.title),
                  controller: _titleController,
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter a title' : null,
                ),
                BlocListener<DateCubit, DateState>(
                  listener: (context, state) {
                    if (state.selectedDate != null) {
                      _dateController.text =
                          _dateFormat.format(state.selectedDate!);
                    }
                  },
                  child: TextFormField(
                    readOnly: true,
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: Colors.black),
                    decoration:
                        InputDecoration(labelText: AppConstants.selectDate),
                    controller: _dateController,
                    onTap: () => Platform.isIOS
                        ? _buildCupertinoDatePicker(context)
                        : materialDatePicker(context),
                    validator: (value) =>
                        value!.isEmpty ? 'Please select a date' : null,
                  ),
                ),
              ],
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.only(top: 20.h),
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => context.pop(),
                      style: Theme.of(context).textButtonTheme.style!.copyWith(
                            backgroundColor: WidgetStatePropertyAll(
                                AppColors.secondaryButtonBg),
                          ),
                      child: Text(
                        AppConstants.cancel,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(width: 20.w),
                  Expanded(
                    child: TextButton(
                      onPressed: () => _saveTodo(context),
                      child: Text(AppConstants.apply,
                          style: Theme.of(context).textTheme.bodyMedium),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
