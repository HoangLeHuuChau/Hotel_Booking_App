import 'package:flutter/material.dart';
import '../models/hotel.dart';
import '../services/hotel_service.dart';

// HotelProvider là một ChangeNotifier, được sử dụng để quản lý trạng thái liên quan đến danh sách khách sạn trong ứng dụng.
class HotelProvider extends ChangeNotifier {
  final HotelService _hotelService; // HotelService được sử dụng để thực hiện các thao tác CRUD với dữ liệu khách sạn.
  List<Hotel> _hotels = []; // Danh sách các khách sạn hiện tại.

  // Constructor của HotelProvider, yêu cầu một HotelService để khởi tạo.
  HotelProvider(this._hotelService);

  // Getter để lấy danh sách các khách sạn hiện tại.
  List<Hotel> get hotels => _hotels;

  // Phương thức fetchHotels để lấy tất cả các khách sạn từ HotelService.
  Future<void> fetchHotels() async {
    _hotels = await _hotelService.readAll(); // Lấy danh sách khách sạn từ dịch vụ.
    notifyListeners(); // Thông báo cho các widget lắng nghe để cập nhật giao diện.
  }

  // Phương thức addHotel để thêm một khách sạn mới.
  Future<void> addHotel(Hotel hotel) async {
    await _hotelService.create(hotel); // Thêm khách sạn mới thông qua dịch vụ.
    await fetchHotels(); // Tải lại danh sách khách sạn để cập nhật.
  }

  // Phương thức updateHotel để cập nhật thông tin khách sạn đã có.
  Future<void> updateHotel(int id, Hotel hotel) async {
    await _hotelService.update(id, hotel); // Cập nhật khách sạn thông qua dịch vụ.
    await fetchHotels(); // Tải lại danh sách khách sạn để cập nhật.
  }

  // Phương thức deleteHotel để xóa một khách sạn dựa trên ID.
  Future<void> deleteHotel(int id) async {
    await _hotelService.delete(id); // Xóa khách sạn thông qua dịch vụ.
    await fetchHotels(); // Tải lại danh sách khách sạn để cập nhật.
  }
}