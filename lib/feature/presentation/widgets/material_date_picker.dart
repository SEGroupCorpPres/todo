import 'package:todo/core/core.dart';
import 'package:todo/feature/feature.dart';

Future<void> materialDatePicker(BuildContext context) async {
  final cubit = context.read<DateCubit>();
  final selectedDate = cubit.state.selectedDate;

  final date = await showDatePicker(
    context: context,
    initialDate: selectedDate ?? DateTime.now(),
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
          inputDecorationTheme: const InputDecorationTheme(
            floatingLabelBehavior: .always,
            contentPadding: .zero,
          ),
        ),
        child: child!,
      );
    },
  );

  if (!context.mounted) return;

  if (date != null && date != selectedDate) {
    context.read<DateCubit>().selectDate(DateTime(date.year, date.month, date.day));
  }
}
