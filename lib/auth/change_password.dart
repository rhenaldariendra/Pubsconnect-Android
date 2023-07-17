import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:thesis_pubsconnect/component/dialog_alert.dart';
import 'package:thesis_pubsconnect/component/dialog_success.dart';
import 'package:thesis_pubsconnect/component/text_field_with_logo.dart';
import 'package:thesis_pubsconnect/model/user_model.dart';
import 'package:thesis_pubsconnect/pages/profile.dart';
import 'package:thesis_pubsconnect/utils/session_provider.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  CustomTextFieldLogo curPassword = CustomTextFieldLogo(
    iconPath: Icons.lock_outline,
    placeholder: 'Current Password',
    isPassword: true,
  );
  CustomTextFieldLogo newPassword = CustomTextFieldLogo(
    iconPath: Icons.lock_outline,
    placeholder: 'New Password',
    isPassword: true,
  );
  CustomTextFieldLogo confPassword = CustomTextFieldLogo(
    iconPath: Icons.lock_outline,
    placeholder: 'Confirm New Password',
    isPassword: true,
  );
  bool _isLoading = false;

  void changePassword() async {
    setState(() {
      _isLoading = true;
    });

    SessionProvider sessionProvider = Provider.of<SessionProvider>(context, listen: false);
    UserModel? users = sessionProvider.getUser();
    await Future.delayed(const Duration(seconds: 2));
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: users!.email,
        password: curPassword.getText().trim(),
      );
      if (newPassword.getText().trim() != confPassword.getText().trim()) {
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (context) {
            return DialogAlert(
              ctx: context,
              placeholder: "New password & confirmation password didn't match",
              titleMessage: 'Error',
              imagePath: 'assets/images/exit.png',
            );
          },
        );
      } else {
        await FirebaseAuth.instance.currentUser!.updatePassword(newPassword.getText());
        // ignore: use_build_context_synchronously
        Navigator.of(context).pop();
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (context) {
            return const DialogSuccess(
              destination: Profile(),
              imagePath: 'assets/images/dialog_images/dialog_2.png',
              titleMessage: 'Success !',
              message: 'Password has been changed successfully',
              buttonMessage: 'Okay',
              isPrimary: false,
              redirect: false,
            );
          },
        );
      }
    } on FirebaseAuthException {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) {
          return DialogAlert(
            ctx: context,
            placeholder: 'Invalid current password',
            titleMessage: 'Error',
            imagePath: 'assets/images/exit.png',
          );
        },
      );
    }

    setState(() {
      _isLoading = false;
    });
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
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 20.w,
                weight: 10,
              ),
            ),
          ),
        ),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              padding: EdgeInsets.symmetric(horizontal: 40.w),
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20.w),
                  child: Image.asset(
                    'assets/images/image_6.png',
                    // width: 276.w,
                  ),
                ),
                SizedBox(
                  height: 24.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 140.w,
                      child: Text(
                        'Change Password',
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w700,
                          fontSize: 32.sp,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16.w,
                    ),
                    curPassword,
                    SizedBox(
                      height: 8.w,
                    ),
                    newPassword,
                    SizedBox(
                      height: 8.w,
                    ),
                    confPassword,
                    SizedBox(
                      height: 32.w,
                    ),
                    Center(
                      child: SizedBox(
                        width: 260.w,
                        height: 40.w,
                        child: ElevatedButton(
                          onPressed: changePassword,
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(11.w),
                            ),
                            padding: EdgeInsets.zero,
                          ),
                          child: const Text('Confirm'),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
