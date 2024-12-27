import 'package:flutter/material.dart';
import '../models/booking.dart';
import '../services/booking_service.dart';

class BookingProvider extends ChangeNotifier {
  final BookingService _bookingService;
  List<Booking> _bookings = [];

  BookingProvider(this._bookingService);

  List<Booking> get bookings => _bookings;

  Future<void> fetchBookings() async {
    _bookings = await _bookingService.readAll();
    notifyListeners();
  }

  Future<void> addBooking(Booking booking) async {
    await _bookingService.create(booking);
    await fetchBookings();
  }

  Future<void> updateBooking(String id, Booking booking) async {
    await _bookingService.update(id, booking);
    await fetchBookings();
  }

  Future<void> deleteBooking(String id) async {
    await _bookingService.delete(id);
    await fetchBookings();
  }
}