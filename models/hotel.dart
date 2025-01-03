class Hotel {
  final int? hotelID;
  final String name;
  final String city;
  final String address;
  final double rating;

  Hotel({
    this.hotelID,
    required this.name,
    required this.city,
    required this.address,
    required this.rating,
  });

  // Deserialize from database map
  factory Hotel.fromMap(Map<String, dynamic> map) {
    return Hotel(
      hotelID: map['hotel_id'],
      name: map['name'],
      city: map['city'],
      address: map['address'],
      rating: map['rating'],
    );
  }

  // Serialize to database map
  Map<String, dynamic> toMap() {
    return {
      'hotel_id': hotelID,
      'name': name,
      'city': city,
      'address': address,
      'rating': rating,
    };
  }
}
