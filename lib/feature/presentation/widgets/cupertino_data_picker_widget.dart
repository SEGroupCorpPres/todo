import 'package:todo/core/core.dart';
import 'package:todo/feature/presentation/presentation.dart';

class CupertinoDataPickerWidget extends StatelessWidget {
  const CupertinoDataPickerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');

    return Container(
      decoration: BoxDecoration(borderRadius: .circular(20), color: Colors.white),
      height: 100.h,
      child: BlocBuilder<DateCubit, DateState>(
        builder: (context, state) {
          return CupertinoDatePicker(
            dateOrder: .dmy,
            mode: .date,
            onDateTimeChanged: (date) {
              if (date != state.selectedDate) {
                context.read<DateCubit>().selectDate(DateTime(date.year, date.month, date.day));
              }
              log(state.selectedDate!.toIso8601String());
            },
            initialDateTime: DateTime(state.selectedDate?.year ?? DateTime.now().year),
            minimumYear: DateTime.now().year,
            maximumDate: DateTime(2100),
          );
        },
      ),
    );
  }
}
