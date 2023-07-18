import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:thesis_pubsconnect/boarding/boarding.dart';
import 'package:thesis_pubsconnect/model/user_model.dart';
import 'package:thesis_pubsconnect/pages/home.dart';
import 'package:thesis_pubsconnect/utils/session_provider.dart';


// import 'package:thesis_pubsconnect/pages/destination.dart';
// import 'package:thesis_pubsconnect/pages/detail_route.dart';
// import 'package:thesis_pubsconnect/pages/information_route.dart';
// import 'package:thesis_pubsconnect/pages/journey.dart';
// import 'package:thesis_pubsconnect/pages/place_detail.dart';

ColorScheme kColorScheme = const ColorScheme(
  brightness: Brightness.light,
  primary: Color.fromRGBO(0, 118, 253, 1),
  onPrimary: Color.fromRGBO(255, 255, 255, 1),
  secondary: Color.fromRGBO(239, 239, 239, 1),
  onSecondary: Color.fromRGBO(44, 44, 44, 1),
  error: Colors.red,
  onError: Color.fromRGBO(255, 255, 255, 1),
  background: Colors.white,
  onBackground: Color.fromRGBO(44, 44, 44, 1),
  surface: Colors.white,
  onSurface: Color.fromRGBO(44, 44, 44, 1),
);

class MainApp extends StatelessWidget {

  const MainApp({super.key});

  User? getCurrentUser() {
    User? user = FirebaseAuth.instance.currentUser;
    return user;
  }

  bool checkLoginStatus(ctx) {
    User? user = getCurrentUser();

    QueryDocumentSnapshot<Object?> docSnapshot;
    Map<String, dynamic> userDatas;
    UserModel userModels;

    if (user != null) {
      SessionProvider sessionProvider =
          Provider.of<SessionProvider>(ctx, listen: false);
      FirebaseFirestore.instance
          .collection('users')
          .where('uid', isEqualTo: user.uid)
          .get()
          .then((QuerySnapshot querySnapshot) => {
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
              });
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Pubsconnect',
          home: child,
          theme: ThemeData().copyWith(
            useMaterial3: true,
            colorScheme: kColorScheme,
            textTheme: ThemeData().textTheme.copyWith(
                  titleLarge: TextStyle(
                    fontFamily: 'Geoma',
                    fontSize: 50.sp, //51
                    color: kColorScheme.primary,
                  ),
                  titleMedium: TextStyle(
                    fontFamily: 'Geoma',
                    fontSize: 32.sp,
                    color: kColorScheme.primary,
                  ),
                  titleSmall: TextStyle(
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w700,
                    fontSize: 24.sp,
                    color: kColorScheme.primary,
                  ),
                  bodyLarge: TextStyle(
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w700,
                    fontSize: 32.sp,
                    color: Colors.black,
                  ),
                  bodyMedium: TextStyle(
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.normal,
                    fontSize: 25.sp,
                    color: Colors.black,
                  ),
                  bodySmall: TextStyle(
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.normal,
                    fontSize: 16.sp,
                    color: Colors.black,
                  ),
                  labelMedium: TextStyle(
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                    color: const Color.fromRGBO(44, 44, 44, 1),
                  ),
                  labelSmall: TextStyle(
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                    letterSpacing: 0,
                    color: Colors.black,
                  ),
                  headlineSmall: TextStyle(
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w700,
                    fontSize: 12.sp,
                    color: kColorScheme.primary,
                  ),
                  headlineMedium: TextStyle(
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                    color: Colors.white, 
                  ),
                  displaySmall: TextStyle(
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w600,
                    fontSize: 18.sp,
                    color: Colors.black54,
                  ),
                ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: kColorScheme.primary, 
                foregroundColor: kColorScheme.onPrimary,
                padding: EdgeInsets.fromLTRB(90.w, 14.w, 90.w, 14.w),
              ),
            ),
          ),
          themeMode: ThemeMode.light,
        );
      },
      child: checkLoginStatus(context) ? const HomeScreen() : const Boarding(),
    );
  }
}
