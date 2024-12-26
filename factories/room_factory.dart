import '../models/room.dart';
import '../interface/factory.dart';

class RoomFactory extends Factory<Room> {
  @override
  Room create(Map<String, dynamic> data) {
    return Room(
      roomId: data['room_id'] as int?,
      hotelId: data['hotel_id'] as int,
      roomType: data['room_type'] as String,
      validFromType: data['valid_from_type'] as String,
      validToType: data['valid_to_type'] as String,
      pricePerNight: (data['price_per_night'] as num).toDouble(),
      validFromPrice: data['valid_from_price'] as String,
      validToPrice: data['valid_to_price'] as String,
    );
  }
}
