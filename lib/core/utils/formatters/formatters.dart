import 'package:todo/core/core.dart';
// Date Format to String

String getDate(String date) {
  return DateFormat('dd/MM/yyyy').format(DateTime.parse(date));
}
