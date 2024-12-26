import 'base_repository.dart';
import '../models/booking.dart';

class BookingRepository extends BaseRepository<Booking> {
  final List<Booking> _bookings = [];

  @override
  Future<void> add(Booking booking) async {
    _bookings.add(booking);
  }

  @override
  Future<List<Booking>> getAll() async {
    return _bookings;
  }

  @override
  Future<void> delete(String id) async {
    _bookings.removeWhere((booking) => booking.bookingId == id);
  }

  @override
  Future<void> update(String id, Booking booking) async {
    final index = _bookings.indexWhere((b) => b.bookingId == id);
    if (index != -1) {
      _bookings[index] = booking;
    }
  }

  @override
  Future<Booking?> findById(String id) async {
    try{
      return _bookings.firstWhere((booking) => booking.bookingId == id);
    }catch (e) {
      return null;
    }
  }
}
