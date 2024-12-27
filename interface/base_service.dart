// Base Service Interface
abstract class BaseService<T> {
  Future<void> create(T item);
  Future<List<T>> readAll();
  Future<T?> readById(String id);
  Future<void> update(String id, T item);
  Future<void> delete(String id);
}