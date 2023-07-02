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
            TransportBox(imagePath: 'assets/images/transport/angkutan_tj.png'),
            TransportBox(imagePath: 'assets/images/transport/angkutan_mrt.png'),
            TransportBox(imagePath: 'assets/images/transport/angkutan_mikrotrans.png'),
            TransportBox(imagePath: 'assets/images/transport/angkutan_kaicommuter.png'),
            TransportBox(imagePath: 'assets/images/transport/angkutan_lrt.png'),
          ],
        ),
        SizedBox(
          height: 16.w,
        ),
      ],
    );
  }
}
