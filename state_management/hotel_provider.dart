import 'package:flutter/material.dart';
import '../models/hotel.dart';
import '../services/hotel_service.dart';

class HotelProvider extends ChangeNotifier {
  final HotelService _hotelService;
  List<Hotel> _hotels = [];

  HotelProvider(this._hotelService);

  List<Hotel> get hotels => _hotels;

  Future<void> fetchHotels() async {
    _hotels = await _hotelService.readAll();
    notifyListeners();
  }

  Future<void> addHotel(Hotel hotel) async {
    await _hotelService.create(hotel);
    await fetchHotels();
  }

  Future<void> updateHotel(int id, Hotel hotel) async {
    await _hotelService.update(id, hotel);
    await fetchHotels();
  }

  Future<void> deleteHotel(int id) async {
    await _hotelService.delete(id);
    await fetchHotels();
  }
}
