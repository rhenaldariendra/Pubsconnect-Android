import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thesis_pubsconnect/api/place_api.dart';
import 'package:thesis_pubsconnect/component/place_card.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

class ExploreCities extends StatefulWidget {
  const ExploreCities({super.key});

  @override
  State<ExploreCities> createState() => _ExploreCitiesState();
}

class _ExploreCitiesState extends State<ExploreCities> {
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
          'Explore Cities',
          style: TextStyle(
            fontFamily: 'Nunito',
            fontWeight: FontWeight.w700,
            fontSize: 24.sp,
            color: Colors.black,
          ),
        ),
      ),
      body: FutureBuilder(
        future: PlaceAPI.getLocation(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data;
            dynamic dataLen = data['data'].length;
            List<TrackSize> arrRow = [];
            if (dataLen > 10) dataLen = 10;
            for (var v = 0; v < dataLen; v++) {
              arrRow.add(auto);
            }
            return SingleChildScrollView(
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
                  for (var index = 0; index < data['data'].length; index++)
                    PlaceCard(
                      data: data['data'][index],
                    ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Center(child: Text('No Data Recorded')),
            );
          } else {
            return const Center(
              child: Center(child: CircularProgressIndicator()),
            );
          }
        },
      ),
    );
  }
}
