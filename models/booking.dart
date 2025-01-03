class Booking {
  final int? bookingId;
  final int userId;
  final int roomId;
  final String checkInDate;
  final String checkOutDate;
  final double totalPrice;

  Booking({
    this.bookingId,
    required this.userId,
    required this.roomId,
    required this.checkInDate,
    required this.checkOutDate,
    required this.totalPrice,
  });

  // Deserialize from database map
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

  // Serialize to database map
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
