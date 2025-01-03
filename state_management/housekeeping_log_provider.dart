import 'package:flutter/material.dart';
import '../models/housekeeping_log.dart';
import '../services/housekeeping_log_service.dart';

// HousekeepingLogProvider là một ChangeNotifier, được sử dụng để quản lý trạng thái liên quan đến nhật ký dọn phòng trong ứng dụng.
class HousekeepingLogProvider extends ChangeNotifier {
  final HousekeepingLogService _housekeepingLogService; // HousekeepingLogService để thực hiện các thao tác CRUD với dữ liệu nhật ký dọn phòng.
  List<HousekeepingLog> _logs = []; // Danh sách các nhật ký dọn phòng hiện tại.

  // Constructor của HousekeepingLogProvider, yêu cầu một HousekeepingLogService để khởi tạo.
  HousekeepingLogProvider(this._housekeepingLogService);

  // Getter để lấy danh sách các nhật ký dọn phòng hiện tại.
  List<HousekeepingLog> get logs => _logs;

  // Phương thức fetchLogs để lấy tất cả các nhật ký dọn phòng từ HousekeepingLogService.
  Future<void> fetchLogs() async {
    _logs = await _housekeepingLogService.readAll(); // Lấy danh sách nhật ký từ dịch vụ.
    notifyListeners(); // Thông báo cho các widget lắng nghe để cập nhật giao diện.
  }

  // Phương thức addLog để thêm một nhật ký dọn phòng mới.
  Future<void> addLog(HousekeepingLog log) async {
    await _housekeepingLogService.create(log); // Thêm nhật ký mới thông qua dịch vụ.
    await fetchLogs(); // Tải lại danh sách nhật ký để cập nhật.
  }

  // Phương thức updateLog để cập nhật thông tin nhật ký dọn phòng đã có.
  Future<void> updateLog(int id, HousekeepingLog log) async {
    await _housekeepingLogService.update(id, log); // Cập nhật nhật ký thông qua dịch vụ.
    await fetchLogs(); // Tải lại danh sách nhật ký để cập nhật.
  }

  // Phương thức deleteLog để xóa một nhật ký dọn phòng dựa trên ID.
  Future<void> deleteLog(int id) async {
    await _housekeepingLogService.delete(id); // Xóa nhật ký thông qua dịch vụ.
    await fetchLogs(); // Tải lại danh sách nhật ký để cập nhật.
  }
}