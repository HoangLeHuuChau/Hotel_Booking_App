class Room {
  final int? roomId; // ID của phòng (có thể null, vì nó được tự động tăng trong database)
  final int hotelId; // ID của khách sạn liên kết với phòng
  final String roomType; // Loại phòng (ví dụ: đơn, đôi, suite,...)
  final String validFromType; // Ngày bắt đầu hiệu lực cho loại phòng
  final String validToType; // Ngày kết thúc hiệu lực cho loại phòng
  final double pricePerNight; // Giá mỗi đêm cho phòng
  final String validFromPrice; // Ngày bắt đầu hiệu lực cho giá phòng
  final String validToPrice; // Ngày kết thúc hiệu lực cho giá phòng

  // Constructor để khởi tạo đối tượng Room
  Room({
    this.roomId, // Có thể null nếu phòng chưa tồn tại trong database
    required this.hotelId, // Bắt buộc, liên kết với ID khách sạn
    required this.roomType, // Bắt buộc, xác định loại phòng
    required this.validFromType, // Bắt buộc, ngày bắt đầu hiệu lực loại phòng
    required this.validToType, // Bắt buộc, ngày kết thúc hiệu lực loại phòng
    required this.pricePerNight, // Bắt buộc, giá mỗi đêm phải lớn hơn 0
    required this.validFromPrice, // Bắt buộc, ngày bắt đầu hiệu lực giá
    required this.validToPrice, // Bắt buộc, ngày kết thúc hiệu lực giá
  });

  // Phương thức để deserialize từ Map của database
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

  // Phương thức để serialize đối tượng Room thành Map cho database
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