import '../models/hotel.dart';
import '../interface/factory.dart';

class HotelFactory extends Factory<Hotel> {
  @override
  Hotel create(Map<String, dynamic> data) {
    return Hotel(
      hotelId: data['hotel_id'] as int?,
      name: data['name'] as String,
      city: data['city'] as String,
      address: data['address'] as String,
      rating: (data['rating'] as num).toDouble(),
    );
  }
}
