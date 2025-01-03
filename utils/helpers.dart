import 'dart:math';

// Class Helpers cung cấp các phương thức tiện ích.
class Helpers {
  /// Tạo một chuỗi ngẫu nhiên với độ dài chỉ định.
  static String generateRandomString(int length) {
    const chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    final Random random = Random();
    return List.generate(length, (index) => chars[random.nextInt(chars.length)]).join();
  }

  /// Kiểm tra định dạng của địa chỉ email.
  static bool isValidEmail(String email) {
    final RegExp emailRegex = RegExp(r"^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}\$", caseSensitive: false);
    return emailRegex.hasMatch(email);
  }

  /// Chuyển đổi một Duration thành chuỗi dễ đọc.
  static String formatDuration(Duration duration) {
    final int hours = duration.inHours; // Số giờ.
    final int minutes = duration.inMinutes % 60; // Số phút.
    final int seconds = duration.inSeconds % 60; // Số giây.
    return [
      if (hours > 0) '$hours h', // Chỉ hiển thị giờ nếu > 0.
      if (minutes > 0) '$minutes m', // Chỉ hiển thị phút nếu > 0.
      '$seconds s' // Luôn hiển thị giây.
    ].join(' ');
  }

  /// Ghi nhật ký một thông điệp với dấu thời gian.
  static void logWithTimestamp(String message) {
    final String timestamp = DateTime.now().toIso8601String();
    print("[$timestamp] $message");
  }
}