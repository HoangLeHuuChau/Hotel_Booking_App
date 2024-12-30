import '../interface/base_repository.dart';
import '../models/hotel.dart';

class HotelRepository implements BaseRepository<Hotel> {
  final List<Hotel> _hotels = [];

  @override
  Future<void> add(Hotel hotel) async {
    try {
      _hotels.add(hotel);
      print('Added hotel: ${hotel.hotelId}');
    } catch (e) {
      throw Exception('Failed to add hotel: $e');
    }
  }

  @override
  Future<List<Hotel>> getAll() async {
    // Simulate asynchronous delay for demonstration
    await Future.delayed(Duration(milliseconds: 500));
    return _hotels;
  }

  @override
  Future<void> delete(String id) async {
    try {
      final initialLength = _hotels.length;
      _hotels.removeWhere((hotel) => hotel.hotelId == id);
      if (_hotels.length == initialLength) {
        throw Exception('Hotel with ID $id not found');
      }
      print('Deleted hotel with ID: $id');
    } catch (e) {
      throw Exception('Failed to delete hotel: $e');
    }
  }

  @override
  Future<void> update(String id, Hotel hotel) async {
    try {
      final index = _hotels.indexWhere((h) => h.hotelId == id);
      if (index == -1) {
        throw Exception('Hotel with ID $id not found for update');
      }
      _hotels[index] = hotel;
      print('Updated hotel with ID: $id');
    } catch (e) {
      throw Exception('Failed to update hotel: $e');
    }
  }

  @override
  Future<Hotel?> findById(String id) async {
    try {
      return _hotels.firstWhere((hotel) => hotel.hotelId == id);
    } catch (e) {
      print('Hotel with ID $id not found');
      return null; // Explicitly return null if no match
    }
  }
}
