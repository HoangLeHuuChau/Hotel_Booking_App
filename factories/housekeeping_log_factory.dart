import '../models/housekeeping_log.dart';
import '../interface/factory.dart';

// HousekeepingLogFactory là một lớp Factory, được sử dụng để tạo các đối tượng HousekeepingLog từ dữ liệu dạng Map.
class HousekeepingLogFactory extends Factory<HousekeepingLog> {
  @override
  HousekeepingLog create(Map<String, dynamic> data) {
    // Tạo một đối tượng HousekeepingLog từ dữ liệu Map với các trường được ánh xạ tương ứng.
    return HousekeepingLog(
      logID: data['logID'] as int?, // ID của nhật ký (nullable, có thể không có khi tạo mới).
      roomID: data['roomID'] as int, // ID của phòng liên quan đến nhật ký dọn phòng.
      employeeID: data['employeeID'] as int, // ID của nhân viên thực hiện dọn phòng.
      cleaningDate: DateTime.parse(data['cleaningDate'] as String), // Ngày thực hiện dọn phòng (chuỗi được parse thành DateTime).
      notes: data['notes'] as String?, // Ghi chú thêm về quá trình dọn phòng (nullable, có thể không có).
    );
  }
}