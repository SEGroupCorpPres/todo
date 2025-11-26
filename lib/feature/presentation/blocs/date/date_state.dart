part of 'date_cubit.dart';

class DateState extends Equatable {
  final DateTime? selectedDate;

  const DateState({this.selectedDate});

  DateState copyWith({DateTime? selectedDate}) {
    return DateState(selectedDate: selectedDate ?? this.selectedDate);
  }

  @override
  List<Object?> get props => [selectedDate];
}
