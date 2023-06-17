import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DialogAlert extends StatelessWidget {
  final BuildContext ctx;
  final dynamic placeholder;
  final String imagePath;

  const DialogAlert({super.key, required this.ctx, required this.placeholder, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.w),
      ),
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      contentPadding: EdgeInsets.fromLTRB(15.w, 10.w, 15.w, 0),
      actionsPadding: EdgeInsets.fromLTRB(15.w, 0, 15.w, 20.w),
      content: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 220.w,
              child: Image.asset(imagePath),
            ),
            SizedBox(
              height: 20.w,
            ),
            Text(
              placeholder,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelMedium,
            )
          ],
        ),
      ),
      actions: [
        SizedBox(
          width: 92.w,
          height: 40.w,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7.w),
              ),
            ),
            onPressed: () {
              Navigator.pop(ctx);
            },
            child: Center(
              child: Text(
                'Okay',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
