import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thesis_pubsconnect/api/weather_api.dart';
import 'package:thesis_pubsconnect/component/loading.dart';

class WeatherCard extends StatefulWidget {
  const WeatherCard({super.key});

  @override
  State<WeatherCard> createState() => _WeatherCardState();
}

class _WeatherCardState extends State<WeatherCard> {
  Map<String, dynamic> weatherData = {};
  Map<String, dynamic> locationData = {};
  String query = 'Jakarta';

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: WeatherApi.getWeather(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data;
          return _weatherCard(data);
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Loading(height: 107.w);
        }
      },
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

    return 'asdasd';
  }

  Widget _weatherCard(data) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20.w),
        ),
        image: DecorationImage(image: AssetImage(_getBackgroundName(data['current']['weather'][0]['icon'])), fit: BoxFit.cover),
      ),
      height: 90.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(
            'https://openweathermap.org/img/wn/${data['current']['weather'][0]['icon']}@4x.png',
            height: double.maxFinite,
            // fit: BoxF,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                data['current']['weather'][0]['description'],
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w700,
                  fontSize: 16.sp,
                  color: Colors.white,
                ),
              ),
              Text(
                'Wind Speed ${data['current']['wind_speed']}km/h',
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
                    (data['current']['temp'] - 273.15).round().toString(),
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
              // Text(
              //   data.cityName,
              //   style: TextStyle(
              //     fontFamily: 'Nunito',
              //     fontWeight: FontWeight.w700,
              //     fontSize: 13.sp,
              //     color: Colors.white,
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
// }
}
