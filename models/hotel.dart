class Hotel {
  final int? hotelId;
  final String name;
  final String city;
  final String address;
  final double rating;

  Hotel({
    this.hotelId,
    required this.name,
    required this.city,
    required this.address,
    required this.rating,
  });

  factory Hotel.fromJson(Map<String, dynamic> json) {
    return Hotel(
      hotelId: json['hotel_id'],
      name: json['name'],
      city: json['city'],
      address: json['address'],
      rating: json['rating'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hotel_id': hotelId,
      'name': name,
      'city': city,
      'address': address,
      'rating': rating,
    };
  }
}
