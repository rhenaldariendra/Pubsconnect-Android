import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InformationRoute extends StatefulWidget {
  const InformationRoute({super.key});

  @override
  State<InformationRoute> createState() => _InformationRouteState();
}

class _InformationRouteState extends State<InformationRoute> {
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
                margin: EdgeInsets.only(left: 17.2),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => print('hjhj'),
              child: Row(
                children: [
                  Container(
                    width: 38.sp,
                    height: 23.sp,
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.all(Radius.circular(6.w))),
                    child: Center(
                      child: Text(
                        '1',
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w600,
                          fontSize: 13.sp,
                          letterSpacing: 0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 12.w,
                  ),
                  Text(
                    'Blok M - Kota',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w600,
                      fontSize: 15.sp,
                      letterSpacing: 0,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

