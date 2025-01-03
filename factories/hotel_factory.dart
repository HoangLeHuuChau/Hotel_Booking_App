import '../models/hotel.dart';
import '../interface/factory.dart';

// HotelFactory là một lớp Factory, được sử dụng để tạo các đối tượng Hotel từ dữ liệu dạng Map.
class HotelFactory extends Factory<Hotel> {
  @override
  Hotel create(Map<String, dynamic> data) {
    // Tạo một đối tượng Hotel từ dữ liệu Map với các trường được ánh xạ tương ứng.
    return Hotel(
      hotelID: data['hotel_id'] as int?, // ID của khách sạn (nullable, có thể không có khi tạo mới).
      name: data['name'] as String, // Tên của khách sạn.
      city: data['city'] as String, // Thành phố nơi khách sạn nằm.
      address: data['address'] as String, // Địa chỉ chi tiết của khách sạn.
      rating: (data['rating'] as num).toDouble(), // Điểm đánh giá trung bình của khách sạn (float).
    );
  }
}