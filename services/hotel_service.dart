import '../interface/base_service.dart';
import '../models/hotel.dart';
import '../repositories/hotel_repository.dart';

class HotelService implements BaseService<Hotel> {
  final HotelRepository _repository;

  HotelService(this._repository);

  @override
  Future<void> create(Hotel hotel) async {
    // Thêm logic nghiệp vụ nếu cần trước khi lưu vào repository.
    await _repository.add(hotel);
  }

  @override
  Future<List<Hotel>> readAll() async {
    return await _repository.getAll();
  }

  @override
  Future<Hotel?> readById(String id) async {
    return await _repository.findById(id);
  }

  @override
  Future<void> update(String id, Hotel hotel) async {
    // Thêm logic nghiệp vụ nếu cần trước khi cập nhật.
    await _repository.update(id, hotel);
  }

  @override
  Future<void> delete(String id) async {
    // Thêm logic nghiệp vụ nếu cần trước khi xóa.
    await _repository.delete(id);
  }
}
