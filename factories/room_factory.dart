import '../models/room.dart'; // Import model Room
import '../interface/factory.dart'; // Import lớp cơ sở Factory

// Factory để tạo đối tượng Room từ dữ liệu thô
class RoomFactory extends Factory<Room> {
  @override
  Room create(Map<String, dynamic> data) {
    // Kiểm tra các trường bắt buộc có trong dữ liệu thô
    if (!data.containsKey('hotel_id') || !data.containsKey('room_type')) {
      throw Exception('Missing required fields in Room data'); // Ném lỗi nếu thiếu trường bắt buộc
    }

    return Room(
      roomId: data['room_id'] as int?, // Lấy ID phòng từ dữ liệu thô
      hotelId: data['hotel_id'] as int, // Lấy ID khách sạn từ dữ liệu thô
      roomType: data['room_type'] as String, // Lấy loại phòng từ dữ liệu thô
      validFromType: data['valid_from_type'] as String, // Lấy thời gian hiệu lực loại phòng từ dữ liệu thô
      validToType: data['valid_to_type'] as String, // Lấy thời gian kết thúc loại phòng từ dữ liệu thô
      pricePerNight: (data['price_per_night'] as num).toDouble(), // Lấy giá mỗi đêm và chuyển đổi sang double
      validFromPrice: data['valid_from_price'] as String, // Lấy thời gian bắt đầu hiệu lực giá
      validToPrice: data['valid_to_price'] as String, // Lấy thời gian kết thúc hiệu lực giá
    );
  }
}
