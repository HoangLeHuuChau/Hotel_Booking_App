import '../repositories/rating_repository.dart';
import '../models/rating.dart';
import '../interface/base_service.dart';

class RatingService implements BaseService<Rating>{
  final RatingRepository _repository;

  RatingService(this._repository);

  @override
  Future<void> create(Rating rating) async {
    // Kiểm tra logic nghiệp vụ trước khi lưu.
    if (rating.score > 5) {
      throw Exception('Score must be at least 5.');
    }
    await _repository.add(rating);
  }

  @override
  Future<List<Rating>> readAll() async {
    return await _repository.getAll();
  }

  @override
  Future<Rating?> readById(int id) async {
    return await _repository.findById(id);
  }

  @override
  Future<void> update(int id, Rating rating) async {
    await _repository.update(id, rating);
  }

  @override
  Future<void> delete(int id) async {
    await _repository.delete(id);
  }
}
