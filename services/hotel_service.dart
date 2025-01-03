import '../models/hotel.dart';
import '../repositories/hotel_repository.dart';
import '../interface/base_service.dart';

// HotelService là một lớp service, quản lý logic nghiệp vụ cho các đối tượng Hotel.
class HotelService implements BaseService<Hotel> {
  final HotelRepository _repository; // Repository để thao tác với cơ sở dữ liệu.

  // Constructor để khởi tạo HotelService với một repository.
  HotelService(this._repository);

  // Phương thức để thêm một khách sạn mới.
  @override
  Future<void> create(Hotel hotel) async {
    await _repository.add(hotel);
  }

  // Phương thức để lấy tất cả các khách sạn.
  @override
  Future<List<Hotel>> readAll() async {
    return await _repository.getAll();
  }

  // Phương thức để lấy thông tin của một khách sạn dựa trên ID.
  @override
  Future<Hotel?> readById(int id) async {
    return await _repository.findById(id);
  }

  // Phương thức để cập nhật thông tin của một khách sạn.
  @override
  Future<void> update(int id, Hotel hotel) async {
    await _repository.update(id, hotel);
  }

  // Phương thức để xóa một khách sạn dựa trên ID.
  @override
  Future<void> delete(int id) async {
    await _repository.delete(id);
  }
}