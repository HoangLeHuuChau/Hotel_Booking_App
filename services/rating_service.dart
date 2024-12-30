import '../interface/base_service.dart';
import '../models/rating.dart';
import '../repositories/rating_repository.dart';

class RatingService implements BaseService<Rating> {
  final RatingRepository _repository;

  // Constructor
  RatingService(this._repository);

  @override
  Future<void> create(Rating item) async {
    await _repository.add(item);
  }

  @override
  Future<List<Rating>> readAll() async {
    return await _repository.getAll();
  }

  @override
  Future<Rating?> readById(String id) async {
    // Sử dụng repository trực tiếp để tìm theo ID
    return await _repository.findById(id);
  }

  @override
  Future<void> update(String id, Rating item) async {
    await _repository.update(id, item);
  }

  @override
  Future<void> delete(String id) async {
    await _repository.delete(id);
  }
}
