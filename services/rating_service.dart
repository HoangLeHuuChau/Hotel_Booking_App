import '../repositories/rating_repository.dart';
import '../models/rating.dart';
import '../interface/base_service.dart';

class RatingService implements BaseService<Rating> {
  // Repository quản lý các thao tác với dữ liệu.
  final RatingRepository _repository;

  // Constructor nhận vào repository.
  RatingService(this._repository);

  @override
  Future<void> create(Rating rating) async {
    // Kiểm tra logic nghiệp vụ trước khi lưu.
    if (rating.score > 5) {
      throw Exception('Score must be at most 5.'); // Điểm số không được vượt quá 5.
    }
    await _repository.add(rating);
  }

  @override
  Future<List<Rating>> readAll() async {
    // Lấy tất cả các đánh giá.
    return await _repository.getAll();
  }

  @override
  Future<Rating?> readById(int id) async {
    // Lấy đánh giá theo ID.
    return await _repository.findById(id);
  }

  @override
  Future<void> update(int id, Rating rating) async {
    // Cập nhật đánh giá theo ID.
    await _repository.update(id, rating);
  }

  @override
  Future<void> delete(int id) async {
    // Xóa đánh giá theo ID.
    await _repository.delete(id);
  }
}
