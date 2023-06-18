import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:thesis_pubsconnect/auth/forgot_password.dart';
import 'package:thesis_pubsconnect/auth/signin.dart';
import 'package:thesis_pubsconnect/auth/signup.dart';
import 'package:thesis_pubsconnect/component/dialog_alert.dart';
import 'package:thesis_pubsconnect/component/text_field.dart';
import 'package:thesis_pubsconnect/model/user_model.dart';
import 'package:thesis_pubsconnect/pages/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:thesis_pubsconnect/utils/session_provider.dart';

class SignForm extends StatefulWidget {
  final String checkForm;

  const SignForm({super.key, required this.checkForm});

  @override
  State<SignForm> createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  CustomTextField email = CustomTextField(name: 'Email');
  CustomTextField name = CustomTextField(name: 'Name');
  CustomTextField password = CustomTextField(name: 'Password');
  CustomTextField gender = CustomTextField(name: 'Gender');
  CustomTextField phone = CustomTextField(name: 'Phone');

  @override
  Widget build(BuildContext context) {
    if (widget.checkForm == 'signin') {
      return signIn(context);
    } else {
      return signUp(context);
    }
  }

  void _submitDataSignUp() async {
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
        SessionProvider sessionProvider = Provider.of<SessionProvider>(context);
        UserModel userModels = UserModel(
          docId: newDocumentRef.id,
          uid: uid,
          name: nameText,
          email: emailText,
          gender: genderText,
          phoneNumber: phoneText,
        );
        sessionProvider.setUser(userModels);
        Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
      }
    } on FirebaseAuthException catch (error) {
      showDialog(
        context: context,
        builder: (ctx) => DialogAlert(
          ctx: ctx,
          placeholder: error.message.toString(),
          imagePath: 'assets/images/exit.png',
        ),
      );
    }

    // await FirebaseAuth.instance
    //     .createUserWithEmailAndPassword(
    //       email: emailText,
    //       password: passwordText,
    //     )
    //     .then(
    //       (value) => {
    //         print('Account Created!'),
    //         Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen())),
    //       },
    //     );
  }

  void _submitDataSignIn() async {
    String emailText = email.getText();
    String passwordText = password.getText();
    bool checkError = false;

    String placeholder = 'Please make sure you enter a valid';

    if (emailText.trim().isEmpty) {
      checkError = true;
      placeholder += ' email';
    }
    if (passwordText.trim().isEmpty) {
      if (checkError == true) {
        placeholder += ',';
      }
      checkError = true;
      placeholder += ' password';
    }

    if (!checkError) {
      QueryDocumentSnapshot<Object?> docSnapshot;
      Map<String, dynamic> userDatas;
      UserModel userModels;
      SessionProvider sessionProvider = Provider.of<SessionProvider>(context, listen: false);

      FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: emailText,
            password: passwordText,
          )
          .then(
            (value) async => {
              print('Logged in'),
              // print(value.user?.uid),
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
              )
            },
          );
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
        email,
        name,
        gender,
        phone,
        password,
        Row(
          children: [
            SizedBox(
              width: 17.w,
              height: 17.w,
              child: Checkbox(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.w),
                ),
                value: false,
                onChanged: null,
                side: const BorderSide(
                  color: Color.fromRGBO(182, 182, 182, 1),
                ),
              ),
            ),
            SizedBox(
              width: 8.w,
            ),
            Text(
              'I accept the Terms of Use.',
              style: TextStyle(
                fontFamily: 'Nunito',
                fontWeight: FontWeight.bold,
                fontSize: 12.sp,
                color: const Color.fromRGBO(142, 142, 142, 1),
              ),
            )
          ],
        ),
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
                onPressed: _submitDataSignUp,
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
        email,
        password,
        Container(
          margin: EdgeInsets.only(bottom: 10.w),
          width: double.infinity,
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => ForgotPassword()));
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
                onPressed: _submitDataSignIn,
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
