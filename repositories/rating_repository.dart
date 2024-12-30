import '../interface/base_repository.dart';
import '../models/rating.dart';

class RatingRepository implements BaseRepository<Rating> {
  final List<Rating> _ratings = [];

  @override
  Future<void> add(Rating rating) async {
    try {
      _ratings.add(rating);
      print('Added rating: ${rating.ratingID}');
    } catch (e) {
      throw Exception('Failed to add rating: $e');
    }
  }

  @override
  Future<List<Rating>> getAll() async {
    // Simulate asynchronous delay
    await Future.delayed(Duration(milliseconds: 500));
    return _ratings;
  }

  @override
  Future<void> delete(String id) async {
    try {
      final initialLength = _ratings.length;
      _ratings.removeWhere((rating) => rating.ratingID == id);
      if (_ratings.length == initialLength) {
        throw Exception('Rating with ID $id not found');
      }
      print('Deleted rating with ID: $id');
    } catch (e) {
      throw Exception('Failed to delete rating: $e');
    }
  }

  @override
  Future<void> update(String id, Rating rating) async {
    try {
      final index = _ratings.indexWhere((r) => r.ratingID == id);
      if (index == -1) {
        throw Exception('Rating with ID $id not found for update');
      }
      _ratings[index] = rating;
      print('Updated rating with ID: $id');
    } catch (e) {
      throw Exception('Failed to update rating: $e');
    }
  }

  @override
  Future<Rating?> findById(String id) async {
    try {
      return _ratings.firstWhere((rating) => rating.ratingID == id);
    } catch (e) {
      print('Rating with ID $id not found');
      return null; // Explicitly return null if no match
    }
  }
}
