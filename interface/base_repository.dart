// Abstract Repository Interface
abstract class BaseRepository<T> {
  Future<List<T>> getAll();
  Future<void> add(T entity);
  Future<void> delete(String id);
  Future<void> update(String id, T item);
  Future<T?> findById(String id);
}