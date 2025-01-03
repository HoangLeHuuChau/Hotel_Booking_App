class HousekeepingLog {
  final int? logID;
  final int roomID;
  final int employeeID;
  final DateTime cleaningDate;
  final String? notes;

  HousekeepingLog({
    required this.logID,
    required this.roomID,
    required this.employeeID,
    required this.cleaningDate,
    this.notes,
  });

  // Deserialize from database map
  factory HousekeepingLog.fromMap(Map<String, dynamic> map) {
    return HousekeepingLog(
      logID: map['logID'] as int?,
      roomID: map['roomID'] as int,
      employeeID: map['staff'] as int, // Assuming staff stores an employee ID
      cleaningDate: DateTime.parse(map['cleaningDate'] as String),
      notes: map['notes'] as String?,
    );
  }
  // Serialize to database map
  Map<String, dynamic> toMap() {
    return {
      'logID': logID,
      'roomID': roomID,
      'staff': employeeID,
      'cleaningDate': cleaningDate.toIso8601String(),
      'notes': notes,
    };
  }
}