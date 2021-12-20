import 'package:intl/intl.dart';

class DataUtils {
  static String numberFormat(double value) {
    return NumberFormat("###,###,###,###").format(value);
  }

  static String simpleDateFormat(DateTime time) {
    return DateFormat("MM.dd").format(time);
  }
}
