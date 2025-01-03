import '../models/booking.dart';
import '../interface/factory.dart';

// Factory cho Booking, tạo đối tượng Booking từ dữ liệu Map.
class BookingFactory extends Factory<Booking> {
  @override
  Booking create(Map<String, dynamic> data) {
    // Tạo đối tượng Booking từ Map với các trường được ánh xạ tương ứng.
    return Booking(
      bookingId: data['booking_id'] as int?, // ID của đặt phòng (nullable).
      userId: data['user_id'] as int, // ID của người dùng.
      roomId: data['room_id'] as int, // ID của phòng.
      checkInDate: data['check_in_date'] as String, // Ngày nhận phòng.
      checkOutDate: data['check_out_date'] as String, // Ngày trả phòng.
      totalPrice: (data['total_price'] as num).toDouble(), // Tổng giá trị đặt phòng.
    );
  }
}