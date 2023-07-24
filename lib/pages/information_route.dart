import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thesis_pubsconnect/api/image_route_api.dart';
import 'package:thesis_pubsconnect/component/loading.dart';
import 'package:thesis_pubsconnect/pages/detail_route.dart';

class InformationRoute extends StatefulWidget {
  final int id;
  final Color color;
  final Color colorText;
  const InformationRoute({super.key, required this.id, required this.color, required this.colorText});

  @override
  State<InformationRoute> createState() => _InformationRouteState();
}

class _InformationRouteState extends State<InformationRoute> {
  @override
  void initState() {
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
              )),
        ),
        title: Text(
          'Information Route',
          style: TextStyle(
            fontFamily: 'Nunito',
            fontWeight: FontWeight.w700,
            fontSize: 24.sp,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(24.w, 20.w, 24.w, 0),
        child: FutureBuilder(
          future: ImageRouteApi.getList(widget.id),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              final data = snapshot.data;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var item in data)
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => DetailRoute(
                            id: item['id'],
                            rute: item['kode']
                                .toString()
                                .toLowerCase()
                                .replaceAll(RegExp(r'[^a-zA-Z0-9\s]'), ''),
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 8.w, 0, 8.w),
                            padding: EdgeInsets.all(10.w),
                            // height: 23.sp,
                            decoration: BoxDecoration(
                                color: widget.color,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6.w))),
                            child: Center(
                              child: Text(
                                item['kode'],
                                style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13.sp,
                                  letterSpacing: 0,
                                  color: widget.colorText,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 12.w,
                          ),
                          Expanded(
                            child: Text(
                              item.containsKey('rute')
                                  ? item['rute']
                                  : 'Transjakarta',
                              style: TextStyle(
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.w600,
                                fontSize: 15.sp,
                                letterSpacing: 0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                ],
              );
            } else if (snapshot.hasError) {
              throw Exception(snapshot.error);
            } else {
              return Loading(height: 300.w);
            }
          },
        ),
      ),
    );
  }
}
