class Rating {
  // Thuộc tính ID của đánh giá, có thể null nếu chưa được lưu vào database.
  final int? ratingID;

  // Thuộc tính ID của người dùng.
  final int userId;

  // Thuộc tính ID của khách sạn.
  final int hotelId;

  // Điểm số đánh giá của người dùng (thang điểm).
  final double score;

  // Nội dung bình luận.
  final String comment;

  // Ngày tạo đánh giá.
  final DateTime date;

  // Constructor để khởi tạo đối tượng Rating.
  Rating({
    this.ratingID,
    required this.userId,
    required this.hotelId,
    required this.score,
    required this.comment,
    required this.date,
  });

  // Tạo đối tượng Rating từ một Map (thường là từ database).
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

  // Chuyển đổi đối tượng Rating thành Map để lưu vào database.
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