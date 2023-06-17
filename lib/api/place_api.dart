import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class PlaceAPI {
  static const _baseUrlOthers = 'https://api.content.tripadvisor.com/api/v1/location/';
  static const _baseUrl = 'https://api.content.tripadvisor.com/api/v1/location/nearby_search?latLong=';
  static const _apiKey = '254ADDF28CC14218AA30E03FF4C1E1F2';
  // static const _apiKey = 'DB85B3E868C74B918818EB3503DC6FFA'; old

  static Future<Map<String, dynamic>> getDetail(id) async {
    // final url = Uri.parse('$_baseUrlOthers/$id/photos?key=$_apiKey&language=en');
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
    // final url = Uri.parse('$_baseUrlOthers/$id/photos?key=$_apiKey&language=en');
    final url = Uri.parse('$_baseUrlOthers$id/photos?key=$_apiKey&language=en');
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
