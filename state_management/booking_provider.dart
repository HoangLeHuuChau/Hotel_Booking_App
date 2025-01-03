import 'package:flutter/material.dart';
import '../models/booking.dart';
import '../services/booking_service.dart';

// Provider cho Booking, quản lý trạng thái liên quan đến đặt phòng trong ứng dụng.
class BookingProvider extends ChangeNotifier {
  final BookingService _bookingService; // Service để gọi logic nghiệp vụ.
  List<Booking> _bookings = []; // Danh sách các đặt phòng hiện tại.

  // Constructor nhận service để khởi tạo.
  BookingProvider(this._bookingService);

  // Getter để lấy danh sách đặt phòng hiện tại.
  List<Booking> get bookings => _bookings;

  // Phương thức fetchBookings để tải danh sách đặt phòng.
  Future<void> fetchBookings() async {
    _bookings = await _bookingService.readAll(); // Lấy danh sách đặt phòng từ service.
    notifyListeners(); // Thông báo cập nhật giao diện.
  }

  // Thêm một đặt phòng mới.
  Future<void> addBooking(Booking booking) async {
    await _bookingService.create(booking); // Thêm đặt phòng qua service.
    await fetchBookings(); // Tải lại danh sách đặt phòng.
  }

  // Cập nhật thông tin đặt phòng.
  Future<void> updateBooking(int id, Booking booking) async {
    await _bookingService.update(id, booking); // Cập nhật đặt phòng qua service.
    await fetchBookings(); // Tải lại danh sách đặt phòng.
  }

  // Xóa đặt phòng theo ID.
  Future<void> deleteBooking(int id) async {
    await _bookingService.delete(id); // Xóa đặt phòng qua service.
    await fetchBookings(); // Tải lại danh sách đặt phòng.
  }
}