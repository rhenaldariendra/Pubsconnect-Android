import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:thesis_pubsconnect/auth/signin.dart';
import 'package:thesis_pubsconnect/component/dialog_confirmation.dart';
import 'package:thesis_pubsconnect/model/user_model.dart';
import 'package:thesis_pubsconnect/pages/explore.dart';
import 'package:thesis_pubsconnect/pages/home.dart';
import 'package:thesis_pubsconnect/utils/session_provider.dart';

class Sidebarr extends StatefulWidget {
  const Sidebarr({super.key});

  @override
  State<Sidebarr> createState() => _SidebarrState();
}

class _SidebarrState extends State<Sidebarr> {
  final _auth = FirebaseAuth.instance;
  late dynamic user;
  late String userEmail;
  late String userName;
  late String userPhoneNumber;
  UserModel? users;

  // void getCurrentUserInfo() async {
  //   user = _auth.currentUser;

  //   userEmail = user.email;
  //   await FirebaseFirestore.instance.collection('users').where('uid', isEqualTo: user.uid).get().then((QuerySnapshot querySnapshot) {
  //     if (querySnapshot.size > 0) {
  //       QueryDocumentSnapshot documentSnapshot = querySnapshot.docs[0];
  //       Map<String, dynamic> userData = documentSnapshot.data() as Map<String, dynamic>;

  //       setState(() {
  //         userName = userData['name'];
  //       });
  //     } else {
  //       setState(() {
  //         userName = 'Users';
  //       });
  //     }
  //   }).catchError((error) {
  //     setState(() {
  //       userName = 'Users';
  //     });
  //   });
  // }

  @override
  void initState() {
    SessionProvider sessionProvider = Provider.of<SessionProvider>(context, listen: false);
    users = sessionProvider.getUser();
    super.initState();
  }

  void logout() {
    SessionProvider sessionProvider = Provider.of<SessionProvider>(context, listen: false);
    FirebaseAuth.instance.signOut().then(
          (value) => {
            print('Logout'),
            sessionProvider.clearSession(),
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const SignIn()),
            ),
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      margin: EdgeInsets.only(top: 35.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildHeader(),
          _buildMenuItems(),
          Expanded(child: Container()),
          SizedBox(
            height: 80.w,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => DialogConfirmation(
                    yesFunction: logout,
                    imagePath: 'assets/images/exit.png',
                    message: 'Are you sure to exit',
                  ),
                );
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomRight: Radius.circular(25.w), bottomLeft: const Radius.circular(0), topLeft: const Radius.circular(0), topRight: const Radius.circular(0))),
                ),
                backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(195, 29, 29, 1)),
              ),
              child: Text(
                'Logout',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w600,
                  fontSize: 18.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 16.w),
          width: double.infinity,
          child: Text(
            'Pubsconnect',
            style: TextStyle(
              fontFamily: 'Geoma',
              fontSize: 36.sp,
              color: const Color.fromRGBO(0, 118, 253, 1),
            ),
            textAlign: TextAlign.left,
          ),
        ),
        SizedBox(
          height: 24.w,
        ),
        SizedBox(
          width: 131.w,
          child: users!.gender == 'Male' ? Image.asset('assets/images/male.png') : Image.asset('assets/images/female.png'),
        ),
        SizedBox(
          height: 8.w,
        ),
        Text(
          users!.name,
          style: TextStyle(
            fontFamily: 'Nunito',
            fontWeight: FontWeight.w500,
            fontSize: 20.sp,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          users!.email,
          style: TextStyle(
            fontFamily: 'Nunito',
            fontWeight: FontWeight.w300,
            fontSize: 16.sp,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItems() {
    return Container(
      margin: EdgeInsets.only(top: 30.w),
      padding: EdgeInsets.only(left: 30.w),
      child: Column(
        children: [
          ListTile(
            dense: true,
            visualDensity: const VisualDensity(vertical: -1),
            leading: const Icon(
              Icons.home_outlined,
              // fill: 1,
              size: 30,
              // weight: 1,
              color: Colors.black54,
            ),
            title: Text('Home', style: Theme.of(context).textTheme.displaySmall),
            onTap: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: ((context) => const HomeScreen()))),
          ),
          ListTile(
            dense: true,
            visualDensity: const VisualDensity(vertical: -1),
            leading: const Icon(
              Icons.location_on_outlined,
              // fill: 1,
              size: 30,
              // weight: 1,
              color: Colors.black54,
            ),
            title: Text('Destination', style: Theme.of(context).textTheme.displaySmall),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: ((context) => const HomeScreen()))),
          ),
          ListTile(
            dense: true,
            visualDensity: const VisualDensity(vertical: -1),
            leading: const Icon(
              Icons.explore_outlined,
              // fill: 1,
              size: 30,
              // weight: 1,
              color: Colors.black54,
            ),
            title: Text('Explorer', style: Theme.of(context).textTheme.displaySmall),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: ((context) => const ExploreCities()))),
          ),
          ListTile(
            dense: true,
            visualDensity: const VisualDensity(vertical: -1),
            leading: const Icon(
              Icons.bookmark_add_outlined,
              // fill: 1,
              size: 30,
              // weight: 1,
              color: Colors.black54,
            ),
            title: Text('Save Place', style: Theme.of(context).textTheme.displaySmall),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: ((context) => const HomeScreen()))),
          ),
          ListTile(
            dense: true,
            visualDensity: const VisualDensity(vertical: -1),
            leading: const Icon(
              Icons.history_outlined,
              // fill: 1,
              size: 30,
              // weight: 1,
              color: Colors.black54,
            ),
            title: Text('History', style: Theme.of(context).textTheme.displaySmall),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: ((context) => const HomeScreen()))),
          ),
        ],
      ),
    );
  }
}
