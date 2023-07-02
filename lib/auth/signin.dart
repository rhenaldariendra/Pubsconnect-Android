// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:thesis_pubsconnect/component/dialog_alert.dart';
import 'package:thesis_pubsconnect/component/sign_form.dart';
import 'package:thesis_pubsconnect/component/text_field.dart';
import 'package:thesis_pubsconnect/model/user_model.dart';
import 'package:thesis_pubsconnect/pages/home.dart';
import 'package:thesis_pubsconnect/utils/session_provider.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool _isLoading = false;
  CustomTextField email = CustomTextField(name: 'Email');
  CustomTextField password = CustomTextField(name: 'Password');

  void _submitDataSignIn() async {
    setState(() {
      _isLoading = true;
    });
    String emailText = email.getText();
    String passwordText = password.getText();
    bool checkError = false;


    if (emailText.trim().isEmpty) {
      checkError = true;
    }
    if (passwordText.trim().isEmpty) {
      checkError = true;
    }

    await Future.delayed(const Duration(seconds: 2));
    if (!checkError) {
      QueryDocumentSnapshot<Object?> docSnapshot;
      Map<String, dynamic> userDatas;
      UserModel userModels;
      SessionProvider sessionProvider = Provider.of<SessionProvider>(context, listen: false);
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(
              email: emailText,
              password: passwordText,
            )
            .then(
              (value) async => {
                print('Logged in'),
                await FirebaseFirestore.instance.collection('users').where('uid', isEqualTo: value.user?.uid).get().then((QuerySnapshot querySnapshot) => {
                      if (querySnapshot.size > 0)
                        {
                          docSnapshot = querySnapshot.docs[0],
                          userDatas = docSnapshot.data() as Map<String, dynamic>,
                          userModels = UserModel(
                            docId: docSnapshot.id,
                            uid: userDatas['uid'],
                            name: userDatas['name'],
                            email: userDatas['email'],
                            gender: userDatas['gender'],
                            phoneNumber: userDatas['phone number'],
                          ),
                          sessionProvider.setUser(userModels),
                        }
                    }),
                setState(() {
                  _isLoading = false;
                }),
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                )
              },
            );
      } on FirebaseAuthException catch (e) {
        setState(() {
          _isLoading = false;
        });
        showDialog(
          context: context,
          builder: (context) => DialogAlert(
            ctx: context,
            titleMessage: 'Error',
            placeholder: 'Oops, please check email or password',
            imagePath: 'assets/images/exit.png',
          ),
        );
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      showDialog(
        context: context,
        builder: (context) => DialogAlert(
          ctx: context,
            titleMessage: 'Error',
            placeholder: 'Oops, please check email or password',
          imagePath: 'assets/images/exit.png',
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
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
                      'assets/images/image_3.png',
                      width: double.infinity,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 24.w, right: 24.w),
                      child: SignForm(
                        checkForm: 'signin',
                        formFunction: _submitDataSignIn,
                        email: email,
                        password: password,
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
