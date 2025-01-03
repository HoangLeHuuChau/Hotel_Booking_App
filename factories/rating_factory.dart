import '../models/rating.dart';
import '../interface/factory.dart';

// RatingFactory là một lớp Factory, được sử dụng để tạo các đối tượng Rating từ dữ liệu dạng Map.
class RatingFactory extends Factory<Rating> {
  @override
  Rating create(Map<String, dynamic> data) {
    // Tạo một đối tượng Rating từ dữ liệu Map với các trường được ánh xạ tương ứng.
    return Rating(
      ratingID: data['id'] as int, // ID của đánh giá.
      userId: data['userId'] as int, // ID của người dùng.
      hotelId: data['hotelId'] as int, // ID của khách sạn.
      score: (data['score'] as num).toDouble(), // Điểm đánh giá (float).
      comment: data['comment'] as String, // Bình luận của người dùng.
      date: DateTime.parse(data['date'] as String), // Ngày đánh giá (chuỗi được parse thành DateTime).
    );
  }
}