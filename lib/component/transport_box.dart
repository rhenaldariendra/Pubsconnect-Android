import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TransportBox extends StatelessWidget {
  final String imagePath;
  final String transportName;
  final int id;

  const TransportBox({super.key, required this.imagePath, required this.transportName, required this.id});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60.w,
      height: 60.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8.w)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.25),
            blurRadius: 4.w,
            offset: Offset(0, 4.w),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            width: 30.w,
          ),
          SizedBox(
            height: 4.w,
          ),
          Text(
            transportName,
            style: TextStyle(
              fontFamily: 'Nunito',
              fontWeight: FontWeight.normal,
              fontSize: 10.sp,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
