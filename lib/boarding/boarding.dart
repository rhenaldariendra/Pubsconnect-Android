import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thesis_pubsconnect/auth/signin.dart';

class Boarding extends StatelessWidget {
  const Boarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 55.w, bottom: 48.w),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome to',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.left,
                ),
                Text(
                  'Pubsconnect',
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 24.w),
            child: Image.asset(
              'assets/images/image_1.png',
              width: 312.w,
            ),
          ),
          SizedBox(
            width: 255.w,
            child: Text(
              'Browse schedule public transport in your city and dont forget to do social distancing',
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 66.w,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) => const SignIn()));
              // Navigator.of(context).pop
            },
            style: Theme.of(context).elevatedButtonTheme.style,
            child: const Text('Get Started'),
          ),
        ],
      ),
    );
  }
}
