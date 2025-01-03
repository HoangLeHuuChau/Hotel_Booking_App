// Abstract Factory định nghĩa phương thức để tạo đối tượng từ dữ liệu thô.
abstract class Factory<T> {
  // Tạo một đối tượng từ một Map (dữ liệu thô).
  T create(Map<String, dynamic> data);
}