import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:thesis_pubsconnect/model/autocomplete_prediction.dart';
import 'package:geolocator/geolocator.dart';

class DestinationAPI {
  static const _baseUrl = 'https://maps.googleapis.com/maps/api';
  static const _apiKey = 'AIzaSyBscF7jto3agk8vn5CjvSdNkMigQ2KMnh8';

  static Future<Map<String, dynamic>> getTransportSuggestion(startLat, startLon, endLat, endLon) async {
    // static void getTransportSuggestion(startLat, startLon, endLat, endLon) async {
    var url = '$_baseUrl/directions/json?origin=';
    if (startLon == 0) {
      // url = Uri.parse('$_baseUrl/directions/json?origin=place_id:$startLat&destination=$endLat,$endLon&mode=transit&alternatives=true&key=$_apiKey&region=id');
      url = '${url}place_id:$startLat&destination=';
    } else {
      url = '$url$startLat,$startLon&destination=';
    }

    if (endLon == 0) {
      url = '${url}place_id:$endLat&mode=transit&alternatives=true&key=$_apiKey&region=id';
    } else {
      url = '$url$endLat,$endLon&mode=transit&alternatives=true&key=$_apiKey&region=id';
    }

    print(url);

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      // print(result);
      return result;
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<AutoCompleteResponse> getSearchAutocomplete(value) async {
    final url = Uri.parse('$_baseUrl/place/autocomplete/json?input=$value&region=id&key=$_apiKey');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body).cast<String, dynamic>();
      AutoCompleteResponse resp = AutoCompleteResponse.fromJson(result);
      // print(result);
      // if(res)

      return resp;
    } else {
      // return null;
      throw Exception('Failed to load data');
    }
  }
}

class AutoCompleteResponse {
  final String? status;
  final List<AutocompletePrediction>? predictions;

  AutoCompleteResponse({this.status, this.predictions});

  factory AutoCompleteResponse.fromJson(Map<String, dynamic> json) {
    return AutoCompleteResponse(
      status: json['status'] as String?,
      predictions: json['predictions'] != null ? json['predictions'].map<AutocompletePrediction>((json) => AutocompletePrediction.fromJson(json)).toList() : null,
    );
  }
}
