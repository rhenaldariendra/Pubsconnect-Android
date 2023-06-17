import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

class WeatherApi {
  static const _baseUrl = 'https://api.openweathermap.org/data/3.0/onecall';
  // static const _apiKey = '64804f4c71b6d92a9cc92b129bb98ebd';
  static const _apiKey = '4ed14121358f50d8780f6d3b7c0921fb';

  late List tests;

  static Future<Map<String, dynamic>> getWeather() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    double lat = position.latitude;
    double lon = position.longitude;

    final response = await http.get(Uri.parse('$_baseUrl?lat=$lat&lon=$lon&appid=$_apiKey'));

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return result;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
