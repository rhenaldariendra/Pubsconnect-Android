import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TripDetail extends StatefulWidget {
  final String startName;
  final String endName;
  const TripDetail({super.key, required this.startName, required this.endName});
  @override
  State<TripDetail> createState() => _TripDetailState();
}

class _TripDetailState extends State<TripDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        margin: EdgeInsets.only(top: 16.w),
        child: IconButton(
          style: IconButton.styleFrom(
            foregroundColor: Colors.white,
            elevation: 0,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 20.w,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      body: Stack(
        children: [
          Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.only(top: 20.w),
            margin: EdgeInsets.only(top: 24.w),
            height: 220.84.w,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/image_7.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                Text(
                  'Your Journey',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w600,
                    fontSize: 21.sp,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 16.w,
                ),
                Container(
                  width: 320.w,
                  height: 100.w,
                  padding: EdgeInsets.fromLTRB(16.w, 16.w, 8.w, 16.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(12.w)),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.25),
                        offset: Offset(0, 4),
                        blurRadius: 4,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/dot.png'),
                      SizedBox(
                        width: 18.w,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.startName,
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          Text(
                            widget.endName,
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          ListView(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30.w), topRight: Radius.circular(30.w)),
                ),
                margin: EdgeInsets.only(top: 190.w),
                padding: EdgeInsets.only(top: 36.w, bottom: 36.w),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      child: Row(
                        children: [
                          Container(
                            width: 65.w,
                            child: Icon(
                              Icons.directions_walk_outlined,
                              size: 24.w,
                            ),
                          ),
                          Text('Duren Tiga'),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Save Trip'),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
