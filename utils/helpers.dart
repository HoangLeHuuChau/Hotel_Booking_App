import 'dart:math';

class Helpers {
  /// Generates a random string of the specified length.
  static String generateRandomString(int length) {
    const chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    final Random random = Random();
    return List.generate(length, (index) => chars[random.nextInt(chars.length)]).join();
  }

  /// Validates an email address format.
  static bool isValidEmail(String email) {
    final RegExp emailRegex = RegExp(r"^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}\$", caseSensitive: false);
    return emailRegex.hasMatch(email);
  }

  /// Converts a duration to a human-readable string.
  static String formatDuration(Duration duration) {
    final int hours = duration.inHours;
    final int minutes = duration.inMinutes % 60;
    final int seconds = duration.inSeconds % 60;
    return [if (hours > 0) '$hours h', if (minutes > 0) '$minutes m', '$seconds s'].join(' ');
  }

  /// Logs a message to the console with a timestamp.
  static void logWithTimestamp(String message) {
    final String timestamp = DateTime.now().toIso8601String();
    print("[$timestamp] $message");
  }
}
