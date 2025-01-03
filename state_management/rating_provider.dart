import 'package:flutter/material.dart';
import '../services/rating_service.dart';
import '../models/rating.dart';

// RatingProvider là một ChangeNotifier, được sử dụng để quản lý trạng thái liên quan đến đánh giá (rating) trong ứng dụng.
class RatingProvider extends ChangeNotifier {
  final RatingService _ratingService; // RatingService được sử dụng để thực hiện các thao tác CRUD với dữ liệu đánh giá.
  List<Rating> _ratings = []; // Danh sách các đánh giá hiện có.

  // Constructor của RatingProvider, yêu cầu một RatingService để khởi tạo.
  RatingProvider(this._ratingService);

  // Getter để lấy danh sách các đánh giá hiện tại.
  List<Rating> get ratings => _ratings;

  // Phương thức fetchRatings để lấy tất cả các đánh giá từ RatingService.
  Future<void> fetchRatings() async {
    _ratings = await _ratingService.readAll(); // Lấy tất cả các đánh giá từ dịch vụ.
    notifyListeners(); // Thông báo cho các widget lắng nghe để cập nhật giao diện.
  }

  // Phương thức addRating để thêm một đánh giá mới.
  Future<void> addRating(Rating rating) async {
    await _ratingService.create(rating); // Thêm đánh giá mới thông qua dịch vụ.
    await fetchRatings(); // Tải lại danh sách các đánh giá để cập nhật.
  }

  // Phương thức updateRating để cập nhật một đánh giá đã có.
  Future<void> updateRating(int id, Rating rating) async {
    await _ratingService.update(id, rating); // Cập nhật đánh giá thông qua dịch vụ.
    await fetchRatings(); // Tải lại danh sách các đánh giá để cập nhật.
  }

  // Phương thức deleteRating để xóa một đánh giá dựa trên ID.
  Future<void> deleteRating(int id) async {
    await _ratingService.delete(id); // Xóa đánh giá thông qua dịch vụ.
    await fetchRatings(); // Tải lại danh sách các đánh giá để cập nhật.
  }
}