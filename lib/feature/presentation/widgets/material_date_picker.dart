import 'package:todo/core/core.dart';
import 'package:todo/feature/feature.dart';

Future<void> materialDatePicker(BuildContext context) async {
  DateCubit cubit = context.watch<DateCubit>();
  final date = await showDatePicker(
    context: context,
    initialDate: DateTime(cubit.state.selectedDate?.year ?? DateTime.now().year),
    firstDate: DateTime(1940),
    lastDate: DateTime(2100),
    helpText: 'ВЫБЕРИТЕ ДАТУ',
    cancelText: 'ОТМЕНА',
    confirmText: 'ВЫБИРАТЬ',
    fieldHintText: 'дд/мм/гггг',
    fieldLabelText: 'Введите дату',
    keyboardType: .datetime,
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          // Buttons
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(textStyle: GoogleFonts.montserrat()),
          ),
          // Input
          inputDecorationTheme: InputDecorationTheme(
            floatingLabelBehavior: .always,
            contentPadding: .zero,
          ),
        ),
        child: child!,
      );
    },
  );
  if (date != cubit.state.selectedDate) {
    context.read<DateCubit>().selectDate(date ?? DateTime.now());
  }
  log(cubit.state.selectedDate!.toIso8601String());
}
