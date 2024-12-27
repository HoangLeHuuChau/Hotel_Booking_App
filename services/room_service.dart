import '../interface/base_service.dart';
import '../models/room.dart';
import '../repositories/room_repository.dart';

class RoomService implements BaseService<Room> {
  final RoomRepository _repository;

  RoomService(this._repository);

  @override
  Future<void> create(Room room) async {
    // Thêm logic nghiệp vụ nếu cần trước khi lưu vào repository.
    await _repository.add(room);
  }

  @override
  Future<List<Room>> readAll() async {
    return await _repository.getAll();
  }

  @override
  Future<Room?> readById(String id) async {
    return await _repository.findById(id);
  }

  @override
  Future<void> update(String id, Room room) async {
    // Thêm logic nghiệp vụ nếu cần trước khi cập nhật.
    await _repository.update(id, room);
  }

  @override
  Future<void> delete(String id) async {
    // Thêm logic nghiệp vụ nếu cần trước khi xóa.
    await _repository.delete(id);
  }
}
