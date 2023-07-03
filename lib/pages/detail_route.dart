import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailRoute extends StatelessWidget {
  const DetailRoute({super.key});

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
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(24.w, 20.w, 24, 0),
        child: Image.asset('assets/images/transport/TransJakarta/1.jpg'),
      ),
    );
  }
}
