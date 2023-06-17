import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thesis_pubsconnect/component/search_field.dart';
import 'package:thesis_pubsconnect/component/sidebar.dart';
import 'package:thesis_pubsconnect/pages/profile.dart';
import 'package:thesis_pubsconnect/view/places.dart';
import 'package:thesis_pubsconnect/view/transport.dart';
import 'package:thesis_pubsconnect/view/weather.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomePageState();
}

class _HomePageState extends State<HomeScreen> {
  Future<void> _refreshData() async {
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _weather = new Weather();
      _place = new Places();
    });
  }

  Weather _weather = Weather();
  Transport _transport = Transport();
  Places _place = Places();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(252, 251, 252, 1),
      drawer: const NavigationDrawer(),
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: const Color.fromRGBO(252, 251, 252, 1),
        titleSpacing: 0,
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () => Scaffold.of(context).openDrawer(),
            icon: Container(
              margin: EdgeInsets.only(left: 17.w),
              child: const Icon(
                Icons.menu,
              ),
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        title: Padding(
          padding: EdgeInsets.only(left: 24.w, right: 24.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Profile(),
                    ),
                  );
                },
                child: Image.asset(
                  'assets/images/male.png',
                  width: 32.w,
                ),
              ),
            ],
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          children: <Widget>[
            Text(
              'Let\'s find your best Route',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(
              height: 7.w,
            ),
            const SearchField(),
            SizedBox(
              height: 16.w,
            ),
            _weather,
            _transport,
            _place,
          ],
        ),
      ),
    );
  }
}

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(25.w),
          bottomRight: Radius.circular(25.w),
        ),
      ),
      width: 268.w,
      surfaceTintColor: Colors.white,
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      child: const Sidebarr(),
      // ),
    );
  }
}
