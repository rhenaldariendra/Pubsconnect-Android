import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:thesis_pubsconnect/auth/change_password.dart';
import 'package:thesis_pubsconnect/component/dialog_success.dart';
import 'package:thesis_pubsconnect/component/text_field_underlined.dart';
import 'package:thesis_pubsconnect/model/user_model.dart';
import 'package:thesis_pubsconnect/utils/session_provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  UserModel? users;
  bool _isLoading = false;

  CustomTextFieldUnderlined? name;
  CustomTextFieldUnderlined? email;
  CustomTextFieldUnderlined? phone;
  CustomTextFieldUnderlined? gender;

  @override
  void initState() {
    SessionProvider sessionProvider = Provider.of<SessionProvider>(context, listen: false);
    users = sessionProvider.getUser();
    name = CustomTextFieldUnderlined(
      value: users!.name,
      titles: 'Full Name',
    );
    email = CustomTextFieldUnderlined(
      value: users!.email,
      titles: 'Email',
    );
    gender = CustomTextFieldUnderlined(
      value: users!.gender,
      titles: 'Gender',
    );
    phone = CustomTextFieldUnderlined(
      value: users!.phoneNumber,
      titles: 'Phone Number',
    );
    super.initState();
  }

  void submitChangeData() async {
    SessionProvider sessionProvider = Provider.of<SessionProvider>(context, listen: false);
    setState(() {
      _isLoading = true;
    });

    String nameText = name!.getText().trim();
    String phoneText = phone!.getText().trim();

    if (nameText != users!.name || phoneText != users!.phoneNumber) {
      FirebaseFirestore.instance.collection('users').doc(users!.docId).update(
        {
          'name': nameText,
          'phone number': phoneText,
        },
      ).then(
        (value) => {
          sessionProvider.refreshData(nameText, phoneText),
        },
      );
    }
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      users = sessionProvider.getUser();
      name!.value = nameText;
      phone!.value = phoneText;
      _isLoading = false;
    });
    // ignore: use_build_context_synchronously
    showDialog(
      context: context,
      builder: (context) {
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
                  child: Image.asset('assets/images/image_5.png'),
                ),
                Text(
                  'Profile updated successfully',
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
                    Navigator.of(context).pop();
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
      },
    );
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
        title: Text(
          'My profile',
          style: TextStyle(
            fontFamily: 'Nunito',
            fontWeight: FontWeight.w700,
            fontSize: 24.sp,
            color: Colors.black,
          ),
        ),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              padding: EdgeInsets.only(top: 30.w, bottom: 30.w),
              children: [
                Container(
                  width: 125.w,
                  height: 125.w,
                  alignment: Alignment.center,
                  child: users!.gender == 'Male' ? Image.asset('assets/images/male.png') : Image.asset('assets/images/female.png'),
                ),
                Container(
                  margin: EdgeInsets.only(top: 25.w),
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      name!,
                      email!,
                      phone!,
                      gender!,
                      Container(
                        margin: EdgeInsets.only(top: 10.w, bottom: 30.w),
                        width: 132.w,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                          ),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const ChangePassword()));
                          },
                          child: Center(
                            child: Text(
                              'Change Password',
                              style: TextStyle(
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.w700,
                                fontSize: 13.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 10.w),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.w),
                          ),
                        ),
                        onPressed: submitChangeData,
                        child: Center(
                          child: Text(
                            'Save',
                            style: TextStyle(
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.w700,
                              fontSize: 16.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
