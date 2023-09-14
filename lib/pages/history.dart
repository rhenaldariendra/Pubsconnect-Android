import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:thesis_pubsconnect/component/ticket.dart';
import 'package:thesis_pubsconnect/utils/session_provider.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List<Map<String, dynamic>> historyList = [];

  Future<List<Map<String, dynamic>>> getHistory() async {
    SessionProvider sessionProvider =
        Provider.of<SessionProvider>(context, listen: false);
    String uid = sessionProvider.getUser()!.uid;
    List<Map<String, dynamic>> arrayOfMaps = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('history')
        .where('uid', isEqualTo: uid)
        .get();
    for (var data in querySnapshot.docs) {
      var datas = data.data() as Map<String, dynamic>;
      arrayOfMaps.add(datas);
      print(datas['destination']);
    }

    return arrayOfMaps;
  }

  @override
  void initState() {
    getHistory().then(
      (value) => {
        setState(
          () {
            historyList = value;
          },
        ),
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(252, 251, 252, 1),
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
          'History',
          style: TextStyle(
            fontFamily: 'Nunito',
            fontWeight: FontWeight.w700,
            fontSize: 24.sp,
            color: Colors.black,
          ),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.only(left: 24..w, right: 24.w),
        itemCount: historyList.length,
        itemBuilder: (content, index) => Ticket(
          transportData: historyList[index]['detail'],
          startName: '',
          endName: historyList[index]['destination'],
          isHome: true,
          isHistory: true,
          time: historyList[index]['date'],
        ),
      ),
    );
  }
}
