import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thesis_pubsconnect/api/image_route_api.dart';
import 'package:thesis_pubsconnect/component/loading.dart';

class DetailRoute extends StatelessWidget {
  final int id;
  final String rute;
  const DetailRoute({super.key, required this.id, required this.rute});

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
                ))),
        title: Text(
          'Detail Information Route',
          style: TextStyle(
            fontFamily: 'Nunito',
            fontWeight: FontWeight.w700,
            fontSize: 24.sp,
            color: Colors.black,
          ),
        ),
      ),
      body: FutureBuilder(
        future: ImageRouteApi.getPhoto(id, rute),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
            // print(rute);
          if (snapshot.hasData) {
            final data = snapshot.data;
            return SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(24.w, 20.w, 24, 0),
              child: Image.network(data),
            );
          }
          else if(snapshot.hasError){
            throw Exception('error');
          }
          else {
            return const Loading(height: double.infinity,);
          }
        },
      ),
    );
  }
}
