import '../interface/base_service.dart';
import '../models/booking.dart';
import '../repositories/booking_repository.dart';

// Service cho Booking, xử lý logic nghiệp vụ liên quan đến đặt phòng.
class BookingService implements BaseService<Booking> {
  final BookingRepository _repository; // Repository để truy cập cơ sở dữ liệu.

  // Constructor nhận repository để khởi tạo.
  BookingService(this._repository);

  // Tạo mới một đặt phòng.
  @override
  Future<void> create(Booking booking) async {
    // Thêm logic nghiệp vụ nếu cần trước khi lưu vào repository.
    await _repository.add(booking);
  }

  // Đọc danh sách tất cả các đặt phòng.
  @override
  Future<List<Booking>> readAll() async {
    return await _repository.getAll();
  }

  // Đọc thông tin đặt phòng theo ID.
  @override
  Future<Booking?> readById(int id) async {
    return await _repository.findById(id);
  }

  // Cập nhật thông tin đặt phòng.
  @override
  Future<void> update(int id, Booking booking) async {
    // Thêm logic nghiệp vụ nếu cần trước khi cập nhật.
    await _repository.update(id, booking);
  }

  // Xóa một đặt phòng.
  @override
  Future<void> delete(int id) async {
    // Thêm logic nghiệp vụ nếu cần trước khi xóa.
    await _repository.delete(id);
  }
}