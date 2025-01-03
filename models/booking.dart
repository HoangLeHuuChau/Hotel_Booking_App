// Model cho Booking, đại diện cho một đặt phòng trong hệ thống.
class Booking {
  final int? bookingId; // ID của đặt phòng, có thể null khi tạo mới.
  final int userId; // ID của người dùng đã thực hiện đặt phòng.
  final int roomId; // ID của phòng được đặt.
  final String checkInDate; // Ngày nhận phòng.
  final String checkOutDate; // Ngày trả phòng.
  final double totalPrice; // Tổng giá trị đặt phòng.

  // Constructor để khởi tạo đối tượng Booking.
  Booking({
    this.bookingId,
    required this.userId,
    required this.roomId,
    required this.checkInDate,
    required this.checkOutDate,
    required this.totalPrice,
  });

  // Deserialize từ một Map (thường từ cơ sở dữ liệu).
  factory Booking.fromMap(Map<String, dynamic> map) {
    return Booking(
      bookingId: map['booking_id'],
      userId: map['user_id'],
      roomId: map['room_id'],
      checkInDate: map['check_in_date'],
      checkOutDate: map['check_out_date'],
      totalPrice: map['total_price'],
    );
  }

  // Serialize đối tượng Booking thành một Map để lưu vào cơ sở dữ liệu.
  Map<String, dynamic> toMap() {
    return {
      'booking_id': bookingId,
      'user_id': userId,
      'room_id': roomId,
      'check_in_date': checkInDate,
      'check_out_date': checkOutDate,
      'total_price': totalPrice,
    };
  }
}