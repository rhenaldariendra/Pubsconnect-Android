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
                builder: ((context) => const InformationRoute(
                      id: 1,
                      color: Color.fromRGBO(50, 128, 195, 1),
                      colorText: Colors.white,
                    )),
              )),
              child: const TransportBox(
                imagePath: 'assets/images/transport/angkutan_tj.png',
                transportName: 'Transjakarta',
                id: 1,
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: ((context) => const InformationRoute(
                      id: 2,
                      color: Color.fromRGBO(36, 44, 92, 1),
                      colorText: Colors.white,
                    )),
              )),
              child: const TransportBox(
                imagePath: 'assets/images/transport/angkutan_mrt.png',
                transportName: 'MRT',
                id: 2,
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: ((context) => const InformationRoute(
                      id: 3,
                      color: Color.fromRGBO(156, 208, 232, 1),
                      colorText: Colors.black,
                    )),
              )),
              child: const TransportBox(
                imagePath: 'assets/images/transport/angkutan_mikrotrans.png',
                transportName: 'Mikrotrans',
                id: 3,
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: ((context) => const InformationRoute(
                      id: 5,
                      color: Color.fromRGBO(236, 28, 36, 1),
                      colorText: Colors.white,
                    )),
              )),
              child: const TransportBox(
                imagePath: 'assets/images/transport/angkutan_kaicommuter.png',
                transportName: 'KRL',
                id: 5,
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: ((context) => const InformationRoute(
                      id: 4,
                      color: Color.fromRGBO(230, 231, 232, 1),
                      colorText: Colors.black,
                    )),
              )),
              child: const TransportBox(
                imagePath: 'assets/images/transport/angkutan_lrt.png',
                transportName: 'LRT',
                id: 4,
              ),
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
