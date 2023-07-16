import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thesis_pubsconnect/component/dashed_line_painter.dart';

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
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.w),
                      topRight: Radius.circular(30.w)),
                ),
                margin: EdgeInsets.only(top: 190.w),
                padding: EdgeInsets.only(top: 36.w, bottom: 36.w),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 90.w,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 65.w,
                            child: Icon(
                              Icons.directions_walk_outlined,
                              size: 24.w,
                            ),
                          ),
                          Container(
                            width: 14.w,
                            height: double.infinity,
                            // color: Colors.black,
                            child: Stack(
                              fit: StackFit.passthrough,
                              children: [
                                Positioned(
                                  top: 7.w,
                                  bottom: 7.w,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    child: CustomPaint(
                                      painter: DashedLinePainter(
                                        isVertical: true,
                                        stroke: 3,
                                        color: Color.fromRGBO(222, 222, 222, 1)
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  child: Container(
                                    width: 14.w,
                                    height: 14.w,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.green,
                                    ),
                                    child: Center(
                                      child: Container(
                                        width: 8.w,
                                        height: 8.w,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 18.w),
                            width: 210.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Duren Tiga',
                                  style: TextStyle(
                                    fontFamily: 'Nunito',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18.sp,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  '6 Stops',
                                  style: TextStyle(
                                    fontFamily: 'Nunito',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13.sp,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '12:21',
                              style: TextStyle(
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.w600,
                                fontSize: 18.sp,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 90.w,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                              left: 10.w,
                              right: 10.w,
                            ),
                            width: 65.w,
                            child: Column(
                              children: [
                                Icon(
                                  Icons.train,
                                  size: 24.w,
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 3.w),
                                  padding:
                                      EdgeInsets.only(top: 2.w, bottom: 2.w),
                                  width: double.infinity,
                                  // color: Colors.blue,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.w)),
                                    color: Colors.blue,
                                  ),
                                  child: Center(
                                    child: Text(
                                      '1',
                                      style: TextStyle(
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 10.sp,
                                        letterSpacing: 0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 14.w,
                            height: double.infinity,
                            // color: Colors.black,
                            child: Stack(
                              fit: StackFit.passthrough,
                              children: [
                                Positioned(
                                  top: 7.w,
                                  bottom: 7.w,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    color: Colors.blue,
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  child: Container(
                                    width: 14.w,
                                    height: 14.w,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.blue,
                                    ),
                                    child: Center(
                                      child: Container(
                                        width: 8.w,
                                        height: 8.w,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  child: Container(
                                    width: 14.w,
                                    height: 14.w,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.blue,
                                    ),
                                    child: Center(
                                      child: Container(
                                        width: 8.w,
                                        height: 8.w,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 18.w),
                            width: 210.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Duren Tiga',
                                  style: TextStyle(
                                    fontFamily: 'Nunito',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18.sp,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  '6 Stops',
                                  style: TextStyle(
                                    fontFamily: 'Nunito',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13.sp,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '12:21',
                              style: TextStyle(
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.w600,
                                fontSize: 18.sp,
                                color: Colors.black,
                              ),
                            ),
                          ),
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
