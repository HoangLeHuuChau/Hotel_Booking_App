import '../interface/repository.dart';

/// BaseRepository implements common methods for all repositories.
abstract class BaseRepository<T> implements IRepository<T> {
  @override
  Future<void> add(T item);

  @override
  Future<List<T>> getAll();

  @override
  Future<void> delete(String id);

  @override
  Future<void> update(String id, T item);

  @override
  Future<T?> findById(String id);
}
