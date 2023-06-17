import 'package:geolocator/geolocator.dart';

class LocationData {
  double latitude;
  double longitude;

  double getLatitude(){ return latitude;}
  double getLongitude(){ return longitude;}

  Future<List> getPos() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    double latitude = position.latitude;
    double longitude = position.longitude;

    return [
      latitude,
      longitude
    ];
  }

  Future<LocationData> getLatLon() async {
    List lst = await getPos();
    return LocationData(latitude: lst[0], longitude: lst[1]);
  }

  LocationData({required this.latitude, required this.longitude});
}
