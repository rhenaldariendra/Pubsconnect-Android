import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thesis_pubsconnect/auth/signin.dart';
import 'package:thesis_pubsconnect/component/dialog_alert.dart';
import 'package:thesis_pubsconnect/component/dialog_success.dart';
import 'package:thesis_pubsconnect/component/text_field_with_logo.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  CustomTextFieldLogo email = CustomTextFieldLogo(
    iconPath: Icons.alternate_email_rounded,
    placeholder: 'Email Address',
    isPassword: false,
  );

  Future submitPasswordChange() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email.getText().trim());
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) {
          return DialogSuccess(
            destination: const SignIn(),
            imagePath: 'assets/images/dialog_images/dialog_8.png',
            message: 'Password reset request has been sent to email ${email.getText().trim()}',
            titleMessage: 'Success !',
            buttonMessage: 'Okay',
            isPrimary: false,
            redirect: true,
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return DialogAlert(
            ctx: context,
            titleMessage: 'Error',
            // placeholder: 'Invalid email, no user record with email ${email.getText().trim()}',
            placeholder: 'Oops, your data is invalid',
            imagePath: 'assets/images/exit.png',
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
        backgroundColor: const Color.fromRGBO(252, 251, 252, 1),
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Container(
              margin: EdgeInsets.only(left: 17.w),
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 20,
                weight: 10,
              ),
            ),
          ),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: 40.w),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 20.w),
                child: Image.asset(
                  'assets/images/image_4.png',
                  // width: 276.w,
                ),
              ),
              SizedBox(
                height: 24.w,
              ),
              SizedBox(
                width: 150.w,
                child: Text(
                  'Forgot Password',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w700,
                    fontSize: 32.sp,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              SizedBox(
                height: 8.w,
              ),
              Text(
                "Don't worry it happened, please enter the email address linked to your account",
                style: Theme.of(context).textTheme.labelSmall,
              ),
              SizedBox(
                height: 16.w,
              ),
            ],
          ),
          email,
          SizedBox(
            height: 30.w,
          ),
          Center(
            child: SizedBox(
              width: 260.w,
              height: 40.w,
              child: ElevatedButton(
                onPressed: submitPasswordChange,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
                child: const Text('Submit'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
