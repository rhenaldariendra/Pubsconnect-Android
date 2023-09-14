// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thesis_pubsconnect/auth/forgot_password.dart';
import 'package:thesis_pubsconnect/auth/signin.dart';
import 'package:thesis_pubsconnect/auth/signup.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignForm extends StatefulWidget {
  final String checkForm;
  final VoidCallback formFunction;
  final email;
  final name;
  final password;
  final gender;
  final phone;

  const SignForm({super.key, required this.checkForm, required this.formFunction, this.email, this.name, this.password, this.gender, this.phone});

  @override
  State<SignForm> createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  // CustomTextField email = CustomTextField(name: 'Email');
  // CustomTextField name = CustomTextField(name: 'Name');
  // CustomTextField password = CustomTextField(name: 'Password');
  // CustomTextField gender = CustomTextField(name: 'Gender');
  // CustomTextField phone = CustomTextField(name: 'Phone');

  @override
  Widget build(BuildContext context) {
    if (widget.checkForm == 'signin') {
      return signIn(context);
    } else {
      return signUp(context);
    }
  }

  Future addUserDetail(id, nameText, emailText, genderText, phoneText) async {
    await FirebaseFirestore.instance.collection('users').add({
      'uid': id,
      'name': nameText,
      'email': emailText,
      'gender': genderText,
      'phone number': phoneText,
    });
  }

  Widget signUp(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 16.w,
        ),
        Text(
          'Sign Up',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        widget.email,
        widget.name,
        widget.gender,
        widget.phone,
        widget.password,
        Container(
          width: double.infinity,
          alignment: Alignment.center,
          margin: EdgeInsets.only(bottom: 71.w, top: 26.w),
          child: Column(
            children: [
              ElevatedButton(
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(Size(260.w, 40.w)),
                  backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.primary),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                ),
                onPressed: widget.formFunction,
                child: Text(
                  'Sign Up',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              SizedBox(
                height: 15.w,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'By continuing you agree to accept our',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,
                      fontSize: 12.sp,
                      color: const Color.fromRGBO(142, 142, 142, 1),
                    ),
                  ),
                  SizedBox(
                    height: 12.w,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        // fixedSize: Size.fromHeight(12.w),
                        padding: EdgeInsets.all(0.w),
                        foregroundColor: Colors.black,
                        textStyle: TextStyle(
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w700,
                          fontSize: 12.sp,
                          color: Colors.black,
                        ),
                      ),
                      onPressed: () {},
                      child: const Text('Privacy Policy & Terms of Service'),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 40.w,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account ?',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) => const SignIn()));
                    },
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget signIn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 16.w,
        ),
        Text(
          'Sign In',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        widget.email,
        widget.password,
        Container(
          margin: EdgeInsets.only(bottom: 10.w),
          width: double.infinity,
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const ForgotPassword()));
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              textStyle: Theme.of(context).textTheme.headlineSmall,
            ),
            child: const Text('Forgot Password?'),
          ),
        ),
        Container(
          width: double.infinity,
          alignment: Alignment.center,
          margin: EdgeInsets.only(bottom: 71.w),
          child: Column(
            children: [
              ElevatedButton(
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(Size(260.w, 40.w)),
                  backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.primary),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                ),
                onPressed: widget.formFunction,
                child: Text(
                  'Sign In',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              SizedBox(
                height: 30.w,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Dont\'t have an account ?',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) => const SignUp()));
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
