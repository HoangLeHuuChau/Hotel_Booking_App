import '../repositories/room_repository.dart';
import '../models/room.dart';
import '../interface/base_service.dart';

class RoomService implements BaseService<Room>{
  final RoomRepository _repository;

  RoomService(this._repository);

  @override
  Future<void> create(Room room) async {
    await _repository.add(room);
  }

  @override
  Future<List<Room>> readAll() async {
    return await _repository.getAll();
  }

  @override
  Future<Room?> readById(int id) async {
    return await _repository.findById(id);
  }

  @override
  Future<void> update(int id, Room room) async {
    await _repository.update(id, room);
  }

  @override
  Future<void> delete(int id) async {
    await _repository.delete(id);
  }
}
