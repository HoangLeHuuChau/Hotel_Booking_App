import '../interface/base_service.dart';
import '../models/booking.dart';
import '../repositories/booking_repository.dart';

class BookingService implements BaseService<Booking> {
  final BookingRepository _repository;

  BookingService(this._repository);

  @override
  Future<void> create(Booking booking) async {
    // Thêm logic nghiệp vụ nếu cần trước khi lưu vào repository.
    await _repository.add(booking);
  }

  @override
  Future<List<Booking>> readAll() async {
    return await _repository.getAll();
  }

  @override
  Future<Booking?> readById(String id) async {
    return await _repository.findById(id);
  }

  @override
  Future<void> update(String id, Booking booking) async {
    // Thêm logic nghiệp vụ nếu cần trước khi cập nhật.
    await _repository.update(id, booking);
  }

  @override
  Future<void> delete(String id) async {
    // Thêm logic nghiệp vụ nếu cần trước khi xóa.
    await _repository.delete(id);
  }
}
