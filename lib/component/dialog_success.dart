import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DialogSuccess extends StatelessWidget {
  final Widget destination;
  final String imagePath;
  final String message;
  final bool redirect;
  const DialogSuccess({super.key, required this.destination, required this.imagePath, required this.message, required this.redirect});

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
                  borderRadius: BorderRadius.circular(7.w),
                ),
                textStyle: Theme.of(context).textTheme.headlineMedium,
                backgroundColor: const Color.fromRGBO(26, 171, 97, 1),
              ),
              child: const Text('Done'),
            ),
          ),
        ),
      ],
    );
  }
}
