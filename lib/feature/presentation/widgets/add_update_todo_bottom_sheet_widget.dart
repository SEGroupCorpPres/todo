import 'package:todo/core/core.dart';
import 'package:todo/feature/data/data.dart';
import 'package:todo/feature/presentation/presentation.dart';

class AddUpdateTodoBottomSheetWidget extends StatefulWidget {
  const AddUpdateTodoBottomSheetWidget({super.key});

  @override
  State<AddUpdateTodoBottomSheetWidget> createState() => _AddUpdateTodoBottomSheetWidgetState();
}

class _AddUpdateTodoBottomSheetWidgetState extends State<AddUpdateTodoBottomSheetWidget> {
  late TextEditingController _titleController;
  late TextEditingController _dateController;

  DateTime _date = DateTime.now();

  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _saveTodo(BuildContext context) async {
    try {
      if (_formKey.currentState!.validate()) {
        TodoModel todo = TodoModel(
          todoId: DateTime.now().microsecondsSinceEpoch.toString(),
          title: _titleController.text,
          endDateTime: _date.toIso8601String(),
          isCompleted: 0,
          createdAt: DateTime.now().toIso8601String(),
          updatedAt: DateTime.now().toIso8601String(),
        );
        context.read<TodoBloc>().add(AddTodoEvent(todo: todo));
        context.read<TodoBloc>().add(GetTodosEvent());
      }
    } catch (e) {
      log(e.toString());
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
    // TODO: implement initState
    _titleController = TextEditingController();
    _dateController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _titleController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              Text(AppConstants.createdTodo, style: Theme.of(context).appBarTheme.titleTextStyle),
              IconButton(
                onPressed: () => context.pop(),
                style: Theme.of(
                  context,
                ).iconButtonTheme.style!.copyWith(backgroundColor: WidgetStateColor.transparent),
                icon: Icon(Icons.close, color: Colors.black),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Colors.black),
                  decoration: InputDecoration(labelText: AppConstants.title),
                  controller: _titleController,
                ),
                BlocBuilder<DateCubit, DateState>(
                  builder: (context, state) {
                    _dateController.text = state.selectedDate == null
                        ? ''
                        : _dateFormat.format(state.selectedDate!);
                    return TextFormField(
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Colors.black),
                      decoration: InputDecoration(labelText: AppConstants.selectDate),
                      controller: _dateController,
                      onTap: () => Platform.isIOS
                          ? _buildCupertinoDatePicker(context)
                          : materialDatePicker(context),
                    );
                  },
                ),
              ],
            ),
          ),
          SafeArea(
            child: Row(
              mainAxisAlignment: .spaceBetween,
              spacing: 20.w,
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => context.pop(),
                    style: Theme.of(context).textButtonTheme.style!.copyWith(
                      backgroundColor: WidgetStatePropertyAll(AppColors.secondaryButtonBg),
                    ),
                    child: Text(
                      AppConstants.cancel,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.black),
                    ),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      _saveTodo(context);
                      context.pop();
                    },
                    child: Text(AppConstants.apply, style: Theme.of(context).textTheme.bodyMedium),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
