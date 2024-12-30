import '../models/housekeeping_log.dart';
import '../interface/factory.dart';

// Factory cho HousekeepingLog
class HousekeepingLogFactory extends Factory<HousekeepingLog> {
  @override
  HousekeepingLog create(Map<String, dynamic> data) {
    return HousekeepingLog(
      logID: data['logID'] as int?,
      roomID: data['roomID'] as int,
      employeeID: data['employeeID'] as int,
      cleaningDate: DateTime.parse(data['cleaningDate'] as String),
      notes: data['notes'] as String?,
    );
  }
}
