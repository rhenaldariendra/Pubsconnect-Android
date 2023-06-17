import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TransportBox extends StatelessWidget {
  final String imagePath;
  const TransportBox({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 47.w,
      height: 47.w,
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
      child: Center(
        child: Image.asset(
          imagePath,
          width: 30.w,
        ),
      ),
    );
  }
}
