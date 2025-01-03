import '../models/hotel.dart';
import '../repositories/hotel_repository.dart';
import '../interface/base_service.dart';

class HotelService implements BaseService<Hotel> {
  final HotelRepository _repository;

  HotelService(this._repository);

  @override
  Future<void> create(Hotel hotel) async {
    await _repository.add(hotel);
  }

  @override
  Future<List<Hotel>> readAll() async {
    return await _repository.getAll();
  }

  @override
  Future<Hotel?> readById(int id) async {
    return await _repository.findById(id);
  }

  @override
  Future<void> update(int id, Hotel hotel) async {
    await _repository.update(id, hotel);
  }

  @override
  Future<void> delete(int id) async {
    await _repository.delete(id);
  }
}
