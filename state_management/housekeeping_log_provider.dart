import 'package:flutter/material.dart';
import '../models/housekeeping_log.dart';
import '../services/housekeeping_log_service.dart';

class HousekeepingLogProvider extends ChangeNotifier {
  final HousekeepingLogService _housekeepingLogService;
  List<HousekeepingLog> _logs = [];

  HousekeepingLogProvider(this._housekeepingLogService);

  List<HousekeepingLog> get logs => _logs;

  Future<void> fetchLogs() async {
    _logs = await _housekeepingLogService.readAll();
    notifyListeners();
  }

  Future<void> addLog(HousekeepingLog log) async {
    await _housekeepingLogService.create(log);
    await fetchLogs();
  }

  Future<void> updateLog(int id, HousekeepingLog log) async {
    await _housekeepingLogService.update(id, log);
    await fetchLogs();
  }

  Future<void> deleteLog(int id) async {
    await _housekeepingLogService.delete(id);
    await fetchLogs();
  }
}
