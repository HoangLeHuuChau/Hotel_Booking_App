import 'base_repository.dart';
import '../models/room.dart';

class RoomRepository extends BaseRepository<Room> {
  final List<Room> _rooms = [];

  @override
  Future<void> add(Room room) async {
    _rooms.add(room);
  }

  @override
  Future<List<Room>> getAll() async {
    return _rooms;
  }

  @override
  Future<void> delete(String id) async {
    _rooms.removeWhere((room) => room.roomId == id);
  }

  @override
  Future<void> update(String id, Room room) async {
    final index = _rooms.indexWhere((r) => r.roomId == id);
    if (index != -1) {
      _rooms[index] = room;
    }
  }

  @override
  Future<Room?> findById(String id) async {
    try{
      return _rooms.firstWhere((room) => room.roomId == id);
    }catch (e) {
      return null;
    }
  }
}
