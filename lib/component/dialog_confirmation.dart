import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DialogConfirmation extends StatelessWidget {
  final VoidCallback yesFunction;
  final String imagePath;
  final String message;

  const DialogConfirmation({super.key, required this.yesFunction, required this.imagePath, required this.message});

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
                    textStyle: Theme.of(context).textTheme.headlineMedium,
                    backgroundColor: const Color.fromRGBO(151, 176, 163, 1),
                  ),
                  child: const Text('No'),
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
                    backgroundColor: const Color.fromRGBO(236, 55, 55, 1),
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
