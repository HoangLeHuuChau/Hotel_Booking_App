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

  // Deserialize JSON to Booking instance
  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      bookingId: json['booking_id'],
      userId: json['user_id'],
      roomId: json['room_id'],
      checkInDate: json['check_in_date'],
      checkOutDate: json['check_out_date'],
      totalPrice: json['total_price'],
    );
  }

  // Serialize Booking instance to JSON
  Map<String, dynamic> toJson() {
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