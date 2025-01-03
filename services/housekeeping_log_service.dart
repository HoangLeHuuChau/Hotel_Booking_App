import '../models/housekeeping_log.dart';
import '../repositories/housekeeping_log_repository.dart';
import '../interface/base_service.dart';

// Service cho HousekeepingLog, cung cấp các chức năng nghiệp vụ.
class HousekeepingLogService implements BaseService<HousekeepingLog> {
  final HousekeepingLogRepository _repository; // Repository để thao tác với database.

  // Constructor để khởi tạo HousekeepingLogService.
  HousekeepingLogService(this._repository);

  // Tạo một bản ghi HousekeepingLog mới.
  @override
  Future<void> create(HousekeepingLog log) async {
    await _repository.add(log); // Gọi phương thức add từ repository.
  }

  // Đọc tất cả các bản ghi HousekeepingLog.
  @override
  Future<List<HousekeepingLog>> readAll() async {
    return await _repository.getAll(); // Gọi phương thức getAll từ repository.
  }

  // Đọc một bản ghi HousekeepingLog dựa trên ID.
  @override
  Future<HousekeepingLog?> readById(int id) async {
    return await _repository.findById(id); // Gọi phương thức findById từ repository.
  }

  // Cập nhật một bản ghi HousekeepingLog dựa trên ID.
  @override
  Future<void> update(int id, HousekeepingLog log) async {
    await _repository.update(id, log); // Gọi phương thức update từ repository.
  }

  // Xóa một bản ghi HousekeepingLog dựa trên ID.
  @override
  Future<void> delete(int id) async {
    await _repository.delete(id); // Gọi phương thức delete từ repository.
  }
}