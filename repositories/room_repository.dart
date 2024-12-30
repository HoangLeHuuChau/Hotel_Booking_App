import '../interface/base_repository.dart';
import '../models/room.dart';

class RoomRepository implements BaseRepository<Room> {
  final List<Room> _rooms = [];

  @override
  Future<void> add(Room room) async {
    try {
      _rooms.add(room);
      print('Room added: ${room.roomId}');
    } catch (e) {
      throw Exception('Failed to add room: $e');
    }
  }

  @override
  Future<List<Room>> getAll() async {
    try {
      return _rooms;
    } catch (e) {
      throw Exception('Failed to fetch rooms: $e');
    }
  }

  @override
  Future<void> delete(String id) async {
    try {
      final initialLength = _rooms.length;
      _rooms.removeWhere((room) => room.roomId.toString() == id);
      if (_rooms.length == initialLength) {
        throw Exception('Room with ID $id not found for deletion');
      }
      print('Room deleted: $id');
    } catch (e) {
      throw Exception('Failed to delete room: $e');
    }
  }

  @override
  Future<void> update(String id, Room room) async {
    try {
      final index = _rooms.indexWhere((r) => r.roomId.toString() == id);
      if (index == -1) {
        throw Exception('Room with ID $id not found for update');
      }
      _rooms[index] = room;
      print('Room updated: $id');
    } catch (e) {
      throw Exception('Failed to update room: $e');
    }
  }

  @override
  Future<Room?> findById(String id) async {
    try {
      return _rooms.firstWhere((room) => room.roomId.toString() == id);
    } catch (e) {
      print('Room with ID $id not found');
      return null;
    }
  }
}
