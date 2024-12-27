import 'package:flutter/material.dart';
import '../models/room.dart';
import '../services/room_service.dart';

class RoomProvider extends ChangeNotifier {
  final RoomService _roomService;
  List<Room> _rooms = [];

  RoomProvider(this._roomService);

  List<Room> get rooms => _rooms;

  Future<void> fetchRooms() async {
    _rooms = await _roomService.readAll();
    notifyListeners();
  }

  Future<void> addRoom(Room room) async {
    await _roomService.create(room);
    await fetchRooms();
  }

  Future<void> updateRoom(String id, Room room) async {
    await _roomService.update(id, room);
    await fetchRooms();
  }

  Future<void> deleteRoom(String id) async {
    await _roomService.delete(id);
    await fetchRooms();
  }
}
