import 'package:intl/intl.dart';

class DateUtil {
  static final DateFormat formatter = DateFormat('dd/MM/yyyy');
  static final DateFormat formatterWithTime = DateFormat('dd/MM/yyyy - HH:mm');
  static final DateFormat onlyTime = DateFormat('HH:mm');

  static String format(DateTime date, {bool time = false}) {
    if (time) {
      return formatterWithTime.format(date);
    }
    return formatter.format(date);
  }

  static String formatOnlyTime(DateTime date) {
    return onlyTime.format(date);
  }

  static DateTime parse(String date) {
    return formatter.parse(date);
  }
}
