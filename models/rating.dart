class Rating {
  final int ratingID; // ID của đánh giá
  final int userId; // ID người dùng đã thực hiện đánh giá
  final int hotelId; // ID của khách sạn được đánh giá
  final double score; // Điểm đánh giá (ví dụ: 4.5/5)
  final String comment; // Nội dung đánh giá
  final DateTime date; // Ngày đánh giá

  Rating({
    required this.ratingID,
    required this.userId,
    required this.hotelId,
    required this.score,
    required this.comment,
    required this.date,
  });

  // Tạo từ JSON
  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      ratingID: json['id'],
      userId: json['userId'],
      hotelId: json['hotelId'],
      score: json['score'].toDouble(),
      comment: json['comment'],
      date: DateTime.parse(json['date']),
    );
  }

  // Chuyển thành JSON
  Map<String, dynamic> toJson() {
    return {
      'id': ratingID,
      'userId': userId,
      'hotelId': hotelId,
      'score': score,
      'comment': comment,
      'date': date.toIso8601String(),
    };
  }
}
