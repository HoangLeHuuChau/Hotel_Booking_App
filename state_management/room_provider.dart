import 'package:flutter/material.dart'; // Import thư viện Flutter cho giao diện người dùng
import '../models/room.dart'; // Import model Room
import '../services/room_service.dart'; // Import dịch vụ RoomService để xử lý dữ liệu phòng

// Provider để quản lý trạng thái và logic liên quan đến phòng
class RoomProvider extends ChangeNotifier {
  final RoomService _roomService; // Dịch vụ xử lý dữ liệu phòng
  List<Room> _rooms = []; // Danh sách phòng hiện tại

  // Constructor nhận RoomService
  RoomProvider(this._roomService);

  // Getter để lấy danh sách phòng
  List<Room> get rooms => _rooms;

  /// Lấy tất cả các phòng và cập nhật trạng thái
  Future<void> fetchRooms() async {
    _rooms = await _roomService.readAll(); // Lấy danh sách phòng từ RoomService
    notifyListeners(); // Thông báo cho giao diện biết trạng thái đã thay đổi
  }

  /// Thêm một phòng mới và làm mới danh sách
  Future<void> addRoom(Room room) async {
    await _roomService.create(room); // Thêm phòng mới
    await fetchRooms(); // Cập nhật danh sách phòng sau khi thêm
  }

  /// Cập nhật thông tin phòng theo ID và làm mới danh sách
  Future<void> updateRoom(int id, Room room) async {
    await _roomService.update(id, room); // Cập nhật thông tin phòng
    await fetchRooms(); // Cập nhật danh sách phòng sau khi sửa đổi
  }

  /// Xóa một phòng theo ID và làm mới danh sách
  Future<void> deleteRoom(int id) async {
    await _roomService.delete(id); // Xóa phòng theo ID
    await fetchRooms(); // Cập nhật danh sách phòng sau khi xóa
  }
}