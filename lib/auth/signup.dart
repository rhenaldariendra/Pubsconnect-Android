import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:thesis_pubsconnect/component/dialog_alert.dart';
import 'package:thesis_pubsconnect/component/dialog_success.dart';
import 'package:thesis_pubsconnect/component/sign_form.dart';
import 'package:thesis_pubsconnect/component/text_field.dart';
import 'package:thesis_pubsconnect/model/user_model.dart';
import 'package:thesis_pubsconnect/pages/home.dart';
import 'package:thesis_pubsconnect/utils/session_provider.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _isLoading = false;
  CustomTextField email = CustomTextField(name: 'Email');
  CustomTextField name = CustomTextField(name: 'Name');
  CustomTextField password = CustomTextField(name: 'Password');
  CustomTextField gender = CustomTextField(name: 'Gender');
  CustomTextField phone = CustomTextField(name: 'Phone');

  void _submitDataSignUp() async {
    setState(() {
      _isLoading = true;
    });
    String nameText = name.getText();
    String emailText = email.getText();
    String passwordText = password.getText();
    String genderText = gender.getGender();
    String phoneText = phone.getText();
    bool checkError = false;

    String placeholder = 'Please make sure you enter all fields available';

    if (emailText.trim().isEmpty) {
      checkError = true;
      // placeholder += ' email';
    }
    if (nameText.trim().isEmpty) {
      // if (checkError == true) {
      //   placeholder += ',';
      // }
      checkError = true;
      // placeholder += ' name';
    }
    if (passwordText.trim().isEmpty) {
      // if (checkError == true) {
      //   placeholder += ',';
      // }
      checkError = true;
      // placeholder += ' password';
    }
    if (genderText.trim().isEmpty) {
      // if (checkError == true) {
      //   placeholder += ',';
      // }
      checkError = true;
      // placeholder += ' password';
    }
    if (phoneText.trim().isEmpty) {
      // if (checkError == true) {
      //   placeholder += ',';
      // }
      checkError = true;
      // placeholder += ' password';
    }

    if (checkError) {
      await Future.delayed(const Duration(seconds: 2));
      setState(() {
        _isLoading = false;
      });
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (ctx) => DialogAlert(
          ctx: ctx,
          placeholder: placeholder,
          imagePath: 'assets/images/exit.png',
        ),
      );
      return;
    }

    await Future.delayed(const Duration(seconds: 2));
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailText,
        password: passwordText,
      );
      if (userCredential.user != null) {
        String uid = userCredential.user!.uid;

        DocumentReference newDocumentRef = await FirebaseFirestore.instance.collection('users').add({
          'uid': uid,
          'name': nameText,
          'email': emailText,
          'gender': genderText,
          'phone number': phoneText,
        });

        // addUserDetail(uid, nameText, emailText, genderText, phoneText);
        SessionProvider sessionProvider = Provider.of<SessionProvider>(context, listen: false);
        UserModel userModels = UserModel(
          docId: newDocumentRef.id,
          uid: uid,
          name: nameText,
          email: emailText,
          gender: genderText,
          phoneNumber: phoneText,
        );
        sessionProvider.setUser(userModels);
        setState(() {
          _isLoading = false;
        });
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (ctx) => const DialogSuccess(
            destination: HomeScreen(),
            imagePath: 'assets/images/image_5.png',
            message: 'Account created successfully',
            redirect: true,
          ),
        );
        // Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
      }
    } on FirebaseAuthException catch (error) {
      setState(() {
        _isLoading = false;
      });
      showDialog(
        context: context,
        builder: (ctx) => DialogAlert(
          ctx: ctx,
          placeholder: error.message.toString(),
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
                      'assets/images/image_2.png',
                      width: double.infinity,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 24.w, right: 24.w),
                      child: SignForm(
                        checkForm: 'signup',
                        formFunction: _submitDataSignUp,
                        name: name,
                        email: email,
                        gender: gender,
                        password: password,
                        phone: phone,
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
