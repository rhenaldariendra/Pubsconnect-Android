// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:thesis_pubsconnect/component/search_field.dart';
import 'package:thesis_pubsconnect/component/sidebar.dart';
import 'package:thesis_pubsconnect/component/ticket.dart';
import 'package:thesis_pubsconnect/model/ticket_model.dart';
import 'package:thesis_pubsconnect/model/user_model.dart';
import 'package:thesis_pubsconnect/pages/profile.dart';
import 'package:thesis_pubsconnect/utils/session_provider.dart';
import 'package:thesis_pubsconnect/view/places.dart';
import 'package:thesis_pubsconnect/view/transport.dart';
import 'package:thesis_pubsconnect/view/weather.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomePageState();
}

class _HomePageState extends State<HomeScreen> {
  UserModel? users;
  TicketModel? ticket;

  Future<void> _refreshData() async {
    await Future.delayed(const Duration(seconds: 2));
    SessionProvider sessionProvider =
        Provider.of<SessionProvider>(context, listen: false);

    setState(() {
      _weather = const Weather();
      _place = const Places();
      users = sessionProvider.getUser();
    });
  }

  @override
  void initState() {
    SessionProvider sessionProvider =
        Provider.of<SessionProvider>(context, listen: false);
    users = sessionProvider.getUser();
    ticket = sessionProvider.getTicket();
    super.initState();
  }

  Weather _weather = const Weather();
  final Transport _transport = const Transport();
  Places _place = const Places();

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
          padding: EdgeInsets.only(left: 16.w, right: 16.w),
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
                child: users?.gender == 'Male'
                    ? Image.asset(
                        'assets/images/male.png',
                        width: 32.w,
                      )
                    : Image.asset(
                        'assets/images/female.png',
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
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          children: <Widget>[
            Text(
              'Let\'s find your best Route',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(
              height: 7.w,
            ),
            SearchField(
              isHome: true,
            ),
            SizedBox(
              height: 16.w,
            ),
            _weather,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ticket == null
                    ? const SizedBox()
                    : Text(
                        'Active Trip',
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 21.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                ticket == null
                    ? const SizedBox()
                    : Ticket(
                        transportData: ticket!.detailRoute,
                        startName: ticket!.startName,
                        endName: ticket!.endName,
                        isHome: true,
                        isHistory: false,
                      ),
              ],
            ),
            SizedBox(
              height: 16.w,
            ),
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
