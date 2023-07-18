// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thesis_pubsconnect/component/detail_trip_card.dart';

class TripDetail extends StatefulWidget {
  final String startName;
  final String endName;
  int unixDepart;
  final List<dynamic> steps;

  TripDetail(
      {super.key,
      required this.startName,
      required this.endName,
      required this.steps, required this.unixDepart});
  @override
  State<TripDetail> createState() => _TripDetailState();
}

class _TripDetailState extends State<TripDetail> {
  // int time = widget.unixDepart;

  bool checkTransitMode(check) {
    if (check == 'WALKING') {
      return true;
    }
    return false;
  }

  Color colorCheck(check) {
    if (!checkTransitMode(check['travel_mode'])) {
      String checks = check['transit_details']['line']['agencies'][0]['name'];

      if (checks.contains('Transportasi Jakarta')) {
        return const Color.fromRGBO(50, 128, 195, 1);
      } else if (checks.contains('MRT')) {
        return const Color.fromRGBO(36, 44, 92, 1);
      } else if (checks.contains('Angkot')) {
        return const Color.fromRGBO(156, 208, 232, 1);
      } else if (checks.contains('LRT')) {
        return const Color.fromRGBO(230, 231, 232, 1);
      } else {
        return const Color.fromRGBO(236, 28, 36, 1);
      }
    } else {
      // return const Color.fromRGBO(27, 172, 71, 1);
      return const Color.fromRGBO(155, 155, 155, 1);
    }
  }

  int getStatus(check) {
    if (check == 0) {
      return 0;
    }
    if (check + 1 == widget.steps.length) {
      return 1;
    }
    return -1;
  }

  int calcTime(int val){
    widget.unixDepart += val;
    return widget.unixDepart;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SizedBox(
        // margin: EdgeInsets.only(top: 10.w),
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
            padding: EdgeInsets.only(top: 50.w),
            height: 280.84.w,
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
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.3),
                      blurRadius: 5.0,
                      offset: Offset(0, -3.0),
                    ),
                  ],
                ),
                margin: EdgeInsets.only(top: 190.w),
                padding: EdgeInsets.only(top: 36.w, bottom: 36.w),
                child: Column(
                  children: [
                    for (int i = 0; i < widget.steps.length; i++)
                      DetailTripCard(
                        isWalking:
                            checkTransitMode(widget.steps[i]['travel_mode']),
                        status: getStatus(i),
                        widgetColor: colorCheck(widget.steps[i]),
                        detail: widget.steps[i],
                        unixDepart: calcTime(widget.steps[i]['duration']['value']),
                      ),

                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Save Trip'),
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
