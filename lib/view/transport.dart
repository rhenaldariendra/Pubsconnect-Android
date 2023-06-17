import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thesis_pubsconnect/component/transport_box.dart';

class Transport extends StatelessWidget {
  const Transport({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Transport',
          style: TextStyle(
            fontFamily: 'Nunito',
            fontSize: 21.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: 16.w,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            TransportBox(imagePath: 'assets/images/bus.png'),
            TransportBox(imagePath: 'assets/images/subway.png'),
            TransportBox(imagePath: 'assets/images/shuttle.png'),
            TransportBox(imagePath: 'assets/images/train.png'),
            TransportBox(imagePath: 'assets/images/mrt.png'),
          ],
        ),
        SizedBox(
          height: 16.w,
        ),
      ],
    );
  }
}
