import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class PlaceAPI {
  static const _baseUrlOthers = 'https://api.content.tripadvisor.com/api/v1/location/'; // getdetail, get photo
  static const _baseUrl = 'https://api.content.tripadvisor.com/api/v1/location/nearby_search?latLong='; // getnearbylocation
  static const _apiKey = '9F4D5176EBA641A9BE504C30C37E84DD';

  static Future<Map<String, dynamic>> getDetail(id) async {
    final url = Uri.parse('$_baseUrlOthers$id/details?key=$_apiKey&language=en&currency=IDR');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return result;
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<Map<String, dynamic>> getPhoto(id) async {
    final url = Uri.parse('$_baseUrlOthers$id/photos?key=$_apiKey&language=en');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return result;
    } else {
      throw Exception('Failed to load data');
    }
  }
  
  static Future<Map<String, dynamic>> getLocationbyId(id) async {
    final url = Uri.parse('$_baseUrlOthers$id/details?key=$_apiKey&language=en&currency=IDR');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return result;
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<Map<String, dynamic>> getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    double lat = position.latitude;
    double lon = position.longitude;
    final url = Uri.parse('$_baseUrl$lat%2C$lon&key=$_apiKey&category=attractions&radiusUnit=5km&language=en');

    final response = await http.get(url, headers: {
      'Accept': 'application/json'
    });
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);

      return result;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
