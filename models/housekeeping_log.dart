// Định nghĩa lớp HousekeepingLog, đại diện cho một bản ghi nhật ký dọn dẹp phòng.
class HousekeepingLog {
  final int? logID; // ID của nhật ký, có thể null (sử dụng khi thêm mới).
  final int roomID; // ID của phòng được dọn dẹp.
  final int employeeID; // ID của nhân viên thực hiện dọn dẹp.
  final DateTime cleaningDate; // Ngày dọn dẹp phòng.
  final String? notes; // Ghi chú bổ sung (nếu có).

  // Constructor để khởi tạo HousekeepingLog.
  HousekeepingLog({
    required this.logID,
    required this.roomID,
    required this.employeeID,
    required this.cleaningDate,
    this.notes,
  });

  // Phương thức factory để tạo một đối tượng HousekeepingLog từ Map (dữ liệu từ database).
  factory HousekeepingLog.fromMap(Map<String, dynamic> map) {
    return HousekeepingLog(
      logID: map['logID'] as int?, // ID của nhật ký (nullable).
      roomID: map['roomID'] as int, // ID của phòng.
      employeeID: map['staff'] as int, // ID của nhân viên (trường "staff" trong database).
      cleaningDate: DateTime.parse(map['cleaningDate'] as String), // Ngày dọn dẹp (chuỗi được parse thành DateTime).
      notes: map['notes'] as String?, // Ghi chú bổ sung (nullable).
    );
  }

  // Phương thức để chuyển đối tượng HousekeepingLog thành Map (để lưu vào database).
  Map<String, dynamic> toMap() {
    return {
      'logID': logID, // ID của nhật ký.
      'roomID': roomID, // ID của phòng.
      'staff': employeeID, // ID của nhân viên.
      'cleaningDate': cleaningDate.toIso8601String(), // Ngày dọn dẹp (chuỗi ISO8601).
      'notes': notes, // Ghi chú bổ sung.
    };
  }
}