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

  // Deserialize JSON to Room instance
  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      roomId: json['room_id'],
      hotelId: json['hotel_id'],
      roomType: json['room_type'],
      validFromType: json['valid_from_type'],
      validToType: json['valid_to_type'],
      pricePerNight: json['price_per_night'],
      validFromPrice: json['valid_from_price'],
      validToPrice: json['valid_to_price'],
    );
  }

  // Serialize Room instance to JSON
  Map<String, dynamic> toJson() {
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