import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thesis_pubsconnect/component/weather_card.dart';

class Weather extends StatelessWidget {
  const Weather({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Today\'s weather',
          style: TextStyle(
            fontFamily: 'Nunito',
            fontSize: 21.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: 16.w,
        ),
        const WeatherCard(),
        SizedBox(
          height: 16.w,
        ),
      ],
    );
  }
}
