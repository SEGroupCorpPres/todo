import 'package:todo/core/core.dart';
import 'package:todo/feature/feature.dart';

class TodosScreen extends StatefulWidget {
  const TodosScreen({super.key});

  @override
  State<TodosScreen> createState() => TodosScreenState();
}

class TodosScreenState extends State<TodosScreen> {
  late TextEditingController _titleController;
  late TextEditingController _dateController;
  DateTime _date = DateTime.now();
  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _titleController = TextEditingController();
    _dateController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log("todos screen");
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        centerTitle: false,
        title: Text(AppConstants.title),
        actions: [
          Container(
            margin: .only(right: 10.w),
            child: IconButton.filled(
              onPressed: () => _showCreateUpdateTodoBottomSheet(context, false),
              icon: const Icon(Icons.add),
            ),
          ),
        ],
      ),
      body: BlocListener<TodoBloc, TodoState>(
        listener: (context, state) {
          if (state is ErrorTodoState) {
            toastification.show(
              context: context,
              style: ToastificationStyle.fillColored,
              title: const Text('Error'),
              description: Text(state.error),
              type: ToastificationType.error,
              autoCloseDuration: const Duration(seconds: 3),
            );
          }
          if (state is UpdateTodoState) {
            toastification.show(
              context: context,
              style: ToastificationStyle.fillColored,
              title: const Text('Success'),
              description: const Text('Todo Updated successfully!'),
              type: ToastificationType.success,
              autoCloseDuration: const Duration(seconds: 3),
            );
          }
          if (state is DeleteTodoState) {
            toastification.show(
              context: context,
              style: ToastificationStyle.fillColored,
              title: const Text('Success'),
              description: const Text('Todo delete successfully!'),
              type: ToastificationType.success,
              autoCloseDuration: const Duration(seconds: 3),
            );
          }
          if (state is CreateTodoState) {
            toastification.show(
              context: context,
              style: ToastificationStyle.fillColored,
              title: const Text('Success'),
              description: const Text('Todo created successfully!'),
              type: ToastificationType.success,
              autoCloseDuration: const Duration(seconds: 3),
            );
          }
        },
        child: SizedBox(
          height:
              MediaQuery.sizeOf(context).height -
              MediaQuery.of(context).padding.top +
              kToolbarHeight.h,
          child: ListView(
            children: [
              TodoTypesList(type: AppConstants.toBeCompleted),
              TodoTypesList(type: AppConstants.inWork),
              TodoTypesList(type: AppConstants.underReview),
              TodoTypesList(type: AppConstants.done),
            ],
          ),
        ),
      ),
    );
  }

  void _showCreateUpdateTodoBottomSheet(BuildContext context, bool? isEdit) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return AddUpdateTodoBottomSheetWidget();
      },
    );
  }
}
