// Model Payment đại diện cho thông tin thanh toán.
class Payment {
  final int paymentID; // ID của thanh toán.
  final int bookingID; // ID của đặt chỗ liên kết với thanh toán.
  final DateTime paymentDate; // Ngày thanh toán.
  final String paymentMethod; // Phương thức thanh toán.
  final double amount; // Số tiền thanh toán.

  // Constructor khởi tạo đối tượng Payment.
  Payment({
    required this.paymentID,
    required this.bookingID,
    required this.paymentDate,
    required this.paymentMethod,
    required this.amount,
  });

  // Tạo đối tượng Payment từ một Map (dữ liệu truy xuất từ database).
  factory Payment.fromMap(Map<String, dynamic> map) {
    return Payment(
      paymentID: map['paymentID'], // ID của thanh toán.
      bookingID: map['bookingID'], // ID của đặt chỗ.
      paymentDate: DateTime.parse(map['paymentDate']), // Parse ngày thanh toán từ chuỗi.
      paymentMethod: map['paymentMethod'], // Phương thức thanh toán.
      amount: map['amount'].toDouble(), // Chuyển số tiền thành double.
    );
  }

  // Chuyển đối tượng Payment thành Map (để lưu trữ vào database).
  Map<String, dynamic> toMap() {
    return {
      'paymentID': paymentID, // ID của thanh toán.
      'bookingID': bookingID, // ID của đặt chỗ.
      'paymentDate': paymentDate.toIso8601String(), // Chuyển ngày thanh toán thành chuỗi ISO 8601.
      'paymentMethod': paymentMethod, // Phương thức thanh toán.
      'amount': amount, // Số tiền thanh toán.
    };
  }
}