import '../interface/base_repository.dart';
import '../models/booking.dart';

class BookingRepository implements BaseRepository<Booking> {
  final List<Booking> _bookings = [];

  @override
  Future<void> add(Booking booking) async {
    try {
      _bookings.add(booking);
      print('Booking added: ${booking.bookingId}');
    } catch (e) {
      throw Exception('Failed to add booking: $e');
    }
  }

  @override
  Future<List<Booking>> getAll() async {
    try {
      return _bookings;
    } catch (e) {
      throw Exception('Failed to fetch bookings: $e');
    }
  }

  @override
  Future<void> delete(String id) async {
    try {
      final initialLength = _bookings.length;
      _bookings.removeWhere((booking) => booking.bookingId == id);

      if (_bookings.length == initialLength) {
        throw Exception('Booking with ID $id not found for deletion');
      }
      print('Booking deleted: $id');
    } catch (e) {
      throw Exception('Failed to delete booking: $e');
    }
  }

  @override
  Future<void> update(String id, Booking booking) async {
    try {
      final index = _bookings.indexWhere((b) => b.bookingId == id);
      if (index == -1) {
        throw Exception('Booking with ID $id not found for update');
      }
      _bookings[index] = booking;
      print('Booking updated: $id');
    } catch (e) {
      throw Exception('Failed to update booking: $e');
    }
  }

  @override
  Future<Booking?> findById(String id) async {
    try {
      return _bookings.firstWhere((booking) => booking.bookingId == id);
    } catch (e) {
      print('Booking with ID $id not found');
      return null; // Return null if no match found
    }
  }
}
