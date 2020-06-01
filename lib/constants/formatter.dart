import 'package:intl/intl.dart';

class Formatter {
  static final currency =
      NumberFormat.currency(name: "COP", symbol: "\$", decimalDigits: 0);
}
