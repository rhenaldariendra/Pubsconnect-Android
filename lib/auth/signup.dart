import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thesis_pubsconnect/component/sign_form.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});


  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Column(
            verticalDirection: VerticalDirection.down,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 32.w, bottom: 24.w),
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Text(
                  'Pubsconnect',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Image.asset(
                'assets/images/image_2.png',
                width: double.infinity,
              ),
              Container(
                padding: EdgeInsets.only(left: 24.w, right: 24.w),
                child: const SignForm(
                  checkForm: 'signup',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
