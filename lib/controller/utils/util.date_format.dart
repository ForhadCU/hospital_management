import 'package:intl/intl.dart';

class CustomDateForamt {
  static mFormateDate(DateTime d) {
    return DateFormat('dd/MM/yyyy').format(d);
  }
}
