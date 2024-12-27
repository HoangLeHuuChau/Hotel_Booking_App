import 'package:intl/intl.dart';

class Formatter {
  /// Formats a date into a human-readable string.
  static String formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  /// Formats a number into currency.
  static String formatCurrency(double amount) {
    final NumberFormat formatter = NumberFormat.currency(symbol: "\$", decimalDigits: 2);
    return formatter.format(amount);
  }

  /// Formats a phone number for display.
  static String formatPhoneNumber(String phoneNumber) {
    return phoneNumber.replaceAllMapped(RegExp(r"(\d{3})(\d{3})(\d{4})"), (Match m) => "(${m[1]}) ${m[2]}-${m[3]}");
  }
}