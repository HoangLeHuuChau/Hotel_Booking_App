// Interface cơ bản cho Repository, định nghĩa các phương thức cần thiết để thao tác với dữ liệu.
abstract class BaseRepository<T> {
  // Lấy danh sách tất cả các mục từ nguồn dữ liệu.
  Future<List<T>> getAll();

  // Thêm một mục mới vào nguồn dữ liệu.
  Future<void> add(T entity);

  // Xóa một mục khỏi nguồn dữ liệu bằng ID.
  Future<void> delete(int id);

  // Cập nhật thông tin của một mục trong nguồn dữ liệu.
  Future<void> update(int id, T item);

  // Tìm một mục trong nguồn dữ liệu bằng ID.
  Future<T?> findById(int id);
}