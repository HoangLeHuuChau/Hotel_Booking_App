import '../models/housekeeping_log.dart';
import '../repositories/housekeeping_log_repository.dart';
import '../interface/base_service.dart';

class HousekeepingLogService implements BaseService<HousekeepingLog>{
  final HousekeepingLogRepository _repository;

  HousekeepingLogService(this._repository);

  @override
  Future<void> create(HousekeepingLog log) async {
    await _repository.add(log);
  }

  @override
  Future<List<HousekeepingLog>> readAll() async {
    return await _repository.getAll();
  }

  @override
  Future<HousekeepingLog?> readById(int id) async {
    return await _repository.findById(id);
  }

  @override
  Future<void> update(int id, HousekeepingLog log) async {
    await _repository.update(id, log);
  }

  @override
  Future<void> delete(int id) async {
    await _repository.delete(id);
  }
}
