import '../repositories/room_repository.dart';
import '../models/room.dart';
import '../interface/base_service.dart';

// Service quản lý các thao tác với Room thông qua repository
class RoomService implements BaseService<Room> {
  final RoomRepository _repository; // Repository liên kết

  // Constructor để khởi tạo RoomService
  RoomService(this._repository);

  @override
  Future<void> create(Room room) async {
    await _repository.add(room); // Gọi repository để thêm phòng
  }

  @override
  Future<List<Room>> readAll() async {
    return await _repository.getAll(); // Gọi repository để lấy tất cả phòng
  }

  @override
  Future<Room?> readById(int id) async {
    return await _repository.findById(id); // Gọi repository để lấy phòng theo ID
  }

  @override
  Future<void> update(int id, Room room) async {
    await _repository.update(id, room); // Gọi repository để cập nhật phòng
  }

  @override
  Future<void> delete(int id) async {
    await _repository.delete(id); // Gọi repository để xóa phòng
  }
}