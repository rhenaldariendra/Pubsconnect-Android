import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DialogConfirmation extends StatelessWidget {
  final VoidCallback yesFunction;
  final String imagePath;
  final String messageTitle;
  final String message;
  final Color color;

  const DialogConfirmation({
    super.key,
    required this.yesFunction,
    required this.imagePath,
    required this.message,
    required this.color,
    required this.messageTitle,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.w),
      ),
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      contentPadding: EdgeInsets.fromLTRB(20.w, 40.w, 20.w, 10.w),
      actionsPadding: EdgeInsets.only(top: 8.w, bottom: 28.w),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 16.w),
              width: 125.w,
              child: Image.asset(imagePath),
            ),
            Text(
              messageTitle,
              style: TextStyle(
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w700,
                fontSize: 24.sp,
                color: color,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 8.w,
            ),
            Text(
              message,
              style: Theme.of(context).textTheme.labelMedium,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
      actions: [
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 92.w,
                height: 40.w,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.w),
                    ),
                    backgroundColor: const Color.fromRGBO(210, 222, 234, 1),
                  ),
                  child: Text(
                    'No',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                      color: color,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              SizedBox(
                width: 92.w,
                height: 40.w,
                child: ElevatedButton(
                  onPressed: yesFunction,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.w),
                    ),
                    textStyle: Theme.of(context).textTheme.headlineMedium,
                    backgroundColor: color,
                  ),
                  child: const Text('Yes'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
