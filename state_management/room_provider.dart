import 'package:flutter/material.dart';
import '../models/room.dart';
import '../services/room_service.dart';

class RoomProvider extends ChangeNotifier {
  final RoomService _roomService;
  List<Room> _rooms = [];

  RoomProvider(this._roomService);

  List<Room> get rooms => _rooms;

  /// Fetch all rooms and update state
  Future<void> fetchRooms() async {
    _rooms = await _roomService.readAll();
    notifyListeners();
  }

  /// Add a new room and refresh list
  Future<void> addRoom(Room room) async {
    await _roomService.create(room);
    await fetchRooms();
  }

  /// Update a room by its ID and refresh list
  Future<void> updateRoom(int id, Room room) async {
    await _roomService.update(id, room);
    await fetchRooms();
  }

  /// Delete a room by its ID and refresh list
  Future<void> deleteRoom(int id) async {
    await _roomService.delete(id);
    await fetchRooms();
  }
}
