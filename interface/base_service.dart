// Interface cơ bản cho Service, định nghĩa các phương thức nghiệp vụ chung.
abstract class BaseService<T> {
  // Tạo một mục mới thông qua service.
  Future<void> create(T item);

  // Đọc danh sách tất cả các mục thông qua service.
  Future<List<T>> readAll();

  // Đọc thông tin chi tiết của một mục thông qua service bằng ID.
  Future<T?> readById(int id);

  // Cập nhật thông tin một mục thông qua service.
  Future<void> update(int id, T item);

  // Xóa một mục thông qua service bằng ID.
  Future<void> delete(int id);
}