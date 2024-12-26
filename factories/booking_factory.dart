import '../models/booking.dart';
import '../interface/factory.dart';

class BookingFactory extends Factory<Booking> {
  @override
  Booking create(Map<String, dynamic> data) {
    return Booking(
      bookingId: data['booking_id'] as int?,
      userId: data['user_id'] as int,
      roomId: data['room_id'] as int,
      checkInDate: data['check_in_date'] as String,
      checkOutDate: data['check_out_date'] as String,
      totalPrice: (data['total_price'] as num).toDouble(),
    );
  }
}
