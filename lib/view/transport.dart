import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thesis_pubsconnect/component/transport_box.dart';
import 'package:thesis_pubsconnect/pages/information_route.dart';

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
          children: [
            GestureDetector(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: ((context) => const InformationRoute(id: 1)),
              )),
              child: TransportBox(
                imagePath: 'assets/images/transport/angkutan_tj.png',
                transportName: 'Transjakarta',
              ),
            ),
            TransportBox(
              imagePath: 'assets/images/transport/angkutan_mrt.png',
              transportName: 'MRT',
            ),
            TransportBox(
              imagePath: 'assets/images/transport/angkutan_mikrotrans.png',
              transportName: 'Mikrotrans',
            ),
            TransportBox(
              imagePath: 'assets/images/transport/angkutan_kaicommuter.png',
              transportName: 'KRL',
            ),
            TransportBox(
              imagePath: 'assets/images/transport/angkutan_lrt.png',
              transportName: 'LRT',
            ),
          ],
        ),
        SizedBox(
          height: 16.w,
        ),
      ],
    );
  }
}
