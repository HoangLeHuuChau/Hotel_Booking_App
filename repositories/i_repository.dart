// Abstract Repository Interface
abstract class IRepository<T> {
  Future<List<T>> getAll();
  Future<void> add(T entity);
}