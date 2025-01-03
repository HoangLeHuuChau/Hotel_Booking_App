class Room {
  final int? roomId;
  final int hotelId;
  final String roomType;
  final String validFromType;
  final String validToType;
  final double pricePerNight;
  final String validFromPrice;
  final String validToPrice;

  Room({
    this.roomId,
    required this.hotelId,
    required this.roomType,
    required this.validFromType,
    required this.validToType,
    required this.pricePerNight,
    required this.validFromPrice,
    required this.validToPrice,
  });

  // Deserialize from database map
  factory Room.fromMap(Map<String, dynamic> map) {
    return Room(
      roomId: map['room_id'] as int?,
      hotelId: map['hotel_id'] as int,
      roomType: map['room_type'] as String,
      validFromType: map['valid_from_type'] as String,
      validToType: map['valid_to_type'] as String,
      pricePerNight: (map['price_per_night'] as num).toDouble(),
      validFromPrice: map['valid_from_price'] as String,
      validToPrice: map['valid_to_price'] as String,
    );
  }

  // Serialize to database map
  Map<String, dynamic> toMap() {
    return {
      'room_id': roomId,
      'hotel_id': hotelId,
      'room_type': roomType,
      'valid_from_type': validFromType,
      'valid_to_type': validToType,
      'price_per_night': pricePerNight,
      'valid_from_price': validFromPrice,
      'valid_to_price': validToPrice,
    };
  }
}
