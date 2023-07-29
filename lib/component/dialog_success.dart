import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DialogSuccess extends StatelessWidget {
  final Widget destination;
  final String imagePath;
  final String message;
  final String buttonMessage;
  final String titleMessage;
  final bool redirect;
  final bool isPrimary;

  const DialogSuccess({
    super.key,
    required this.destination,
    required this.imagePath,
    required this.message,
    required this.redirect,
    required this.isPrimary,
    required this.buttonMessage,
    required this.titleMessage,
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
              titleMessage,
              style: TextStyle(
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w700,
                fontSize: 24.sp,
                color: isPrimary
                    ? const Color.fromRGBO(61, 76, 94, 1)
                    : const Color.fromRGBO(26, 171, 97, 1),
              ),
            ),
            SizedBox(
              height: 16.w,
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
          child: SizedBox(
            width: 110.w,
            height: 40.w,
            child: ElevatedButton(
              onPressed: () {
                redirect
                    ? Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => destination,
                        ),
                      )
                    : Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(23.w),
                ),
                textStyle: Theme.of(context).textTheme.headlineMedium,
                backgroundColor: isPrimary
                    ? const Color.fromRGBO(0, 118, 253, 1)
                    : const Color.fromRGBO(26, 171, 97, 1),
              ),
              child: const Text('Done'),
            ),
          ),
        ),
      ],
    );
  }
}
