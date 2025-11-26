import 'package:todo/core/core.dart';
part 'date_state.dart';

class DateCubit extends Cubit<DateState> {
  DateCubit() : super(const DateState());

  void selectDate(DateTime date) {
    emit(state.copyWith(selectedDate: date));
  }
}
