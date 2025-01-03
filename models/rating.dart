class Rating {
  final int? ratingID;
  final int userId;
  final int hotelId;
  final double score;
  final String comment;
  final DateTime date;

  Rating({
    this.ratingID,
    required this.userId,
    required this.hotelId,
    required this.score,
    required this.comment,
    required this.date,
  });

  // Deserialize from database map
  factory Rating.fromMap(Map<String, dynamic> map) {
    return Rating(
      ratingID: map['rating_id'] as int?,
      userId: map['user_id'] as int,
      hotelId: map['hotel_id'] as int,
      score: (map['score'] as num).toDouble(),
      comment: map['comment'] as String,
      date: DateTime.parse(map['date'] as String),
    );
  }

  // Serialize to database map
  Map<String, dynamic> toMap() {
    return {
      'rating_id': ratingID,
      'user_id': userId,
      'hotel_id': hotelId,
      'score': score,
      'comment': comment,
      'date': date.toIso8601String(),
    };
  }
}
