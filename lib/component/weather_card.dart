import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WeatherCard extends StatefulWidget {
  final Map<String, dynamic> data;
  const WeatherCard({super.key, required this.data});
  @override
  State<WeatherCard> createState() => _WeatherCardState();
}

class _WeatherCardState extends State<WeatherCard> {
  Map<String, dynamic> weatherData = {};
  Map<String, dynamic> locationData = {};
  String query = 'Jakarta';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.w),
      // foregroundDecoration: BoxDecoration,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20.w),
        ),
        image: DecorationImage(image: AssetImage(_getBackgroundName(widget.data['current']['weather'][0]['icon'])), fit: BoxFit.cover),
      ),
      height: 90.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(
            'https://openweathermap.org/img/wn/${widget.data['current']['weather'][0]['icon']}@4x.png',
            height: double.maxFinite,
            // fit: BoxF,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                widget.data['current']['weather'][0]['main'],
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w700,
                  fontSize: 16.sp,
                  color: Colors.white,
                ),
              ),
              Text(
                'Wind Speed ${widget.data['current']['wind_speed']}km/h',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.normal,
                  fontSize: 13.sp,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(
            width: 5.w,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    (widget.data['current']['temp'] - 273.15).round().toString(),
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w700,
                      fontSize: 40.sp,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 7.w),
                    width: 9.w,
                    height: 9.w,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 2.w),
                      color: Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
              Text(
                widget.data['cityName'],
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w700,
                  fontSize: 13.sp,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getBackgroundName(data) {
    if (data == '02d' || data == '03d' || data == '50d') {
      return 'assets/images/background_weather/sunny_cloudy.png';
    }
    if (data == '01d') {
      return 'assets/images/background_weather/sunny.png';
    }
    if (data == '04n' || data == '50n' || data == '01n') {
      return 'assets/images/background_weather/moon.png';
    }
    if (data == '04d' || data == '10d' || data == '03n') {
      return 'assets/images/background_weather/rain.png';
    }
    if (data == '10n' || data == '09d' || data == '02n' || data == '09n') {
      return 'assets/images/background_weather/moon_cloudy.png';
    }
    if (data == '11d' || data == '11n') {
      return 'assets/images/background_weather/thunderstorm.png';
    }
    
    return 'assets/images/background_weather/sunny_cloudy.png';
  }
}
