class Hotel {
  final int? hotelID; // ID của khách sạn (nullable, có thể không có khi tạo mới).
  final String name; // Tên khách sạn.
  final String city; // Thành phố nơi khách sạn nằm.
  final String address; // Địa chỉ đầy đủ của khách sạn.
  final double rating; // Đánh giá trung bình của khách sạn (float).

  // Constructor để khởi tạo một đối tượng Hotel.
  Hotel({
    this.hotelID,
    required this.name,
    required this.city,
    required this.address,
    required this.rating,
  });

  // Phương thức từ Map (deserialize) để tạo một đối tượng Hotel từ dữ liệu dạng Map.
  factory Hotel.fromMap(Map<String, dynamic> map) {
    return Hotel(
      hotelID: map['hotel_id'], // Lấy ID của khách sạn từ Map.
      name: map['name'], // Lấy tên khách sạn từ Map.
      city: map['city'], // Lấy thành phố từ Map.
      address: map['address'], // Lấy địa chỉ từ Map.
      rating: map['rating'], // Lấy đánh giá từ Map.
    );
  }

  // Phương thức toMap (serialize) để chuyển đổi một đối tượng Hotel thành Map.
  Map<String, dynamic> toMap() {
    return {
      'hotel_id': hotelID, // Đưa ID của khách sạn vào Map.
      'name': name, // Đưa tên khách sạn vào Map.
      'city': city, // Đưa thành phố vào Map.
      'address': address, // Đưa địa chỉ vào Map.
      'rating': rating, // Đưa đánh giá vào Map.
    };
  }
}