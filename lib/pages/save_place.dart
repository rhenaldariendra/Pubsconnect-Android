import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:thesis_pubsconnect/api/place_api.dart';
import 'package:thesis_pubsconnect/component/loading.dart';
import 'package:thesis_pubsconnect/component/place_card.dart';
import 'package:thesis_pubsconnect/model/user_model.dart';
import 'package:thesis_pubsconnect/utils/session_provider.dart';

class SavePlace extends StatefulWidget {
  const SavePlace({super.key});

  @override
  State<SavePlace> createState() => _SavePlaceState();
}

class _SavePlaceState extends State<SavePlace> {
  List<Map<String, dynamic>> savedPlaces = [];
  List<TrackSize> arrRow = [
    auto
  ];

  Future<List<Map<String, dynamic>>> _getSavedPlace() async {
    SessionProvider sessionProvider = Provider.of<SessionProvider>(context, listen: false);
    UserModel? users = sessionProvider.getUser();
    List<Map<String, dynamic>> arrayOfMaps = [];
    print(users?.uid);
    List<QueryDocumentSnapshot<Object?>> docSnapshot;
    Map<String, dynamic> item = {};
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('save_place').where('user id', isEqualTo: users!.uid).get();
    dynamic listItem;
    for (var data in querySnapshot.docs) {
      var place_ids = data.data() as Map<String, dynamic>;
      if (place_ids['user id'] == users.uid) {
        listItem = {
          'place_id': place_ids['place_id'],
        };
        arrayOfMaps.add(listItem);
      }
    }
    var dataLen = arrayOfMaps.length;
    if (dataLen > 10) dataLen = 10;
    for (var v = 1; v < dataLen; v++) arrRow.add(auto);
    // ignore: avoid_print, prefer_interpolation_to_compose_strings
    print('object' + dataLen.toString());
    print(arrRow.length);
    return arrayOfMaps;
  }

  @override
  void initState() {
    _getSavedPlace().then(
      (value) => {
        setState(
          () {
            savedPlaces = value;
          },
        ),
      },
    );
    super.initState();
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
          'Saved Place',
          style: TextStyle(
            fontFamily: 'Nunito',
            fontWeight: FontWeight.w700,
            fontSize: 24.sp,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.w, 20.w, 10.w, 0),
        child: LayoutGrid(
          columnSizes: [
            1.fr,
            1.fr
          ],
          rowSizes: arrRow,
          rowGap: 16.w,
          columnGap: 24.w,
          children: [
            for (var index = 0; index < savedPlaces.length; index++)
              FutureBuilder(
                future: PlaceAPI.getDetail(savedPlaces[index]['place_id']),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    final data = snapshot.data;
                    // print(data);
                    return PlaceCard(
                      data: data,
                    );
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Center(child: Text('No Data Recorded')),
                    );
                  } else {
                    return Loading(height: 170.w);
                  }
                },
              ),
            // PlaceCard(
            //   data: data['data'][index],
            // ),
          ],
        ),
      ),
    );
  }
}

// FutureBuilder(
//         future: _getSavedPlace(),
//         builder: (BuildContext context, AsyncSnapshot snapshot) {
//           print(snapshot.data);
//           return Text(snapshot.data[0]['place_id']);
          // final data = snapshot.data;
          // dynamic dataLen = data['data'].length;
          // List<TrackSize> arrRow = [];
          // if (dataLen > 10) dataLen = 10;
          // for (var v = 0; v < dataLen; v++) {
          //   arrRow.add(auto);
          // }
          // return SingleChildScrollView(
          //   padding: EdgeInsets.fromLTRB(10.w, 20.w, 10.w, 0),
          //   child: LayoutGrid(
          //     columnSizes: [
          //       1.fr,
          //       1.fr
          //     ],
          //     rowSizes: arrRow,
          //     rowGap: 16.w,
          //     columnGap: 24.w,
          //     children: [
          //       for (var index = 0; index < data['data'].length; index++)
          //         PlaceCard(
          //           data: data['data'][index],
          //         ),
          //     ],
          //   ),
          // );
      //   },
      // ),