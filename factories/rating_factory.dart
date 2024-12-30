import '../models/rating.dart';
import '../interface/factory.dart';

// Factory cho Rating
class RatingFactory extends Factory<Rating> {
  @override
  Rating create(Map<String, dynamic> data) {
    return Rating(
      ratingID: data['id'] as int,
      userId: data['userId'] as int,
      hotelId: data['hotelId'] as int,
      score: (data['score'] as num).toDouble(),
      comment: data['comment'] as String,
      date: DateTime.parse(data['date'] as String),
    );
  }
}