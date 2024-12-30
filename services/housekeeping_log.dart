import '../interface/base_service.dart';
import '../models/housekeeping_log.dart';
import '../repositories/housekeeping_log_repository.dart';

// Service cho HousekeepingLog
class HousekeepingLogService implements BaseService<HousekeepingLog>{
  final HousekeepingLogRepository _repository;

  HousekeepingLogService(this._repository);

  Future<void> create(HousekeepingLog log) async {
    await _repository.add(log);
  }

  Future<List<HousekeepingLog>> readAll() async {
    return await _repository.getAll();
  }

  Future<HousekeepingLog?> readById(String id) async {
    return await _repository.findById(id);
  }

  Future<void> update(String id, HousekeepingLog log) async {
    await _repository.update(id, log);
  }

  Future<void> delete(String id) async {
    await _repository.delete(id);
  }
}