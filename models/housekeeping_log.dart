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

  /// Factory constructor for creating a `HousekeepingLog` from JSON.
  factory HousekeepingLog.fromJson(Map<String, dynamic> json) {
    return HousekeepingLog(
      logID: json['logID'] as int?,
      roomID: json['roomID'] as int,
      employeeID: json['staff'] as int, // Assuming staff stores an employee ID
      cleaningDate: DateTime.parse(json['cleaningDate'] as String),
      notes: json['notes'] as String?,
    );
  }
  /// Convert the `HousekeepingLog` instance to JSON.
  Map<String, dynamic> toJson() {
    return {
      'logID': logID,
      'roomID': roomID,
      'staff': employeeID,
      'cleaningDate': cleaningDate.toIso8601String(),
      'notes': notes,
    };
  }
}