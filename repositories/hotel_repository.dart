import 'base_repository.dart';
import '../models/hotel.dart';

class HotelRepository extends BaseRepository<Hotel> {
  final List<Hotel> _hotels = [];

  @override
  Future<void> add(Hotel hotel) async {
    _hotels.add(hotel);
  }

  @override
  Future<List<Hotel>> getAll() async {
    return _hotels;
  }

  @override
  Future<void> delete(String id) async {
    _hotels.removeWhere((hotel) => hotel.hotelId == id);
  }

  @override
  Future<void> update(String id, Hotel hotel) async {
    final index = _hotels.indexWhere((h) => h.hotelId == id);
    if (index != -1) {
      _hotels[index] = hotel;
    }
  }

  @override
  Future<Hotel?> findById(String id) async {
    try {
      return _hotels.firstWhere((hotel) => hotel.hotelId.toString() == id);
    } catch (e) {
      return null; // Return null explicitly if no match is found
    }
  }
}
