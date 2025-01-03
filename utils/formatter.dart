import 'package:intl/intl.dart';

// Class Formatter cung cấp các phương thức định dạng dữ liệu.
class Formatter {
  /// Định dạng ngày thành chuỗi dễ đọc.
  static String formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  /// Định dạng số thành chuỗi tiền tệ.
  static String formatCurrency(double amount) {
    final NumberFormat formatter = NumberFormat.currency(symbol: "\$", decimalDigits: 2);
    return formatter.format(amount);
  }

  /// Định dạng số điện thoại thành chuỗi hiển thị.
  static String formatPhoneNumber(String phoneNumber) {
    return phoneNumber.replaceAllMapped(
      RegExp(r"(\d{3})(\d{3})(\d{4})"),
          (Match m) => "(${m[1]}) ${m[2]}-${m[3]}",
    );
  }
}