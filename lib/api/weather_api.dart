import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

class WeatherApi {
  static const _baseUrl = 'https://api.openweathermap.org/data/3.0/onecall';
  static const _locationUrl = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=';

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
    final response2 = await http.get(Uri.parse('$_locationUrl$lat,$lon&key=AIzaSyBscF7jto3agk8vn5CjvSdNkMigQ2KMnh8'));

    String temp = '';
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);

      if (response2.statusCode == 200) {
        var res = jsonDecode(response2.body);
        for (var element in res['results'][0]['address_components']) {
          if (element['types'][0] == 'administrative_area_level_4') {
            temp = element['short_name'];
          }
        }
        if (temp == '') {
          temp = 'Jakarta';
        }
      } else {
        temp = 'Jakarta';
      }
      result['cityName'] = temp;
      // print(temp);
      return result;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
