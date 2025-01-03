import 'package:flutter/material.dart';
import '../services/rating_service.dart';
import '../models/rating.dart';

class RatingProvider extends ChangeNotifier {
  final RatingService _ratingService;
  List<Rating> _ratings = [];

  RatingProvider(this._ratingService);

  List<Rating> get ratings => _ratings;

  Future<void> fetchRatings() async {
    _ratings = await _ratingService.readAll();
    notifyListeners();
  }

  Future<void> addRating(Rating rating) async {
    await _ratingService.create(rating);
    await fetchRatings();
  }

  Future<void> updateRating(int id, Rating rating) async {
    await _ratingService.update(id, rating);
    await fetchRatings();
  }

  Future<void> deleteRating(int id) async {
    await _ratingService.delete(id);
    await fetchRatings();
  }
}
