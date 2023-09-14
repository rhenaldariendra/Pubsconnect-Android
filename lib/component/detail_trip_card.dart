import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:thesis_pubsconnect/component/dashed_line_painter.dart';

class DetailTripCard extends StatefulWidget {
  final bool isWalking;
  final int status;
  final int unixDepart;
  final Color widgetColor;
  final Map<String, dynamic> detail;

  const DetailTripCard(
      {super.key,
      required this.isWalking,
      required this.status,
      required this.widgetColor,
      required this.detail, required this.unixDepart});

  @override
  State<DetailTripCard> createState() => _DetailTripCardState();
}

class _DetailTripCardState extends State<DetailTripCard> {
  String kode = ' ';
  double lastHeight = 0.0;
  

  @override
  void initState() {
    if(widget.detail['travel_mode']!='WALKING') {
      if(widget.detail['transit_details']['line']['vehicle']['type'] == 'TRAM') {
        kode = 'LRT';
      }
      else if(widget.detail['transit_details']['line']['vehicle']['type'] == 'TRAIN') {
        kode = 'KRL';
      }
      else if(widget.detail['transit_details']['line']['vehicle']['type'] == 'SUBWAY') {
        kode = 'MRT';
      }
      else if(widget.detail['transit_details']['line']['agencies'][0]['name'].contains('Transportasi Jakarta')) {
        kode = 'Transjakarta';
      }
      else if(widget.detail['transit_details']['line']['agencies'][0]['name'].contains('Angkot')) {
        kode = 'Mikrotrans - Angkot';
      }
    }

    // convertDateTime();

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      calculateTextHeight();
    });
  }
  void calculateTextHeight() {
    setState(() {
      RenderBox renderBox = textKey.currentContext!.findRenderObject() as RenderBox;
      lastHeight = renderBox.size.height;
    });
  }

  GlobalKey textKey = GlobalKey();


  String convertDistance(val) {
      String str = '';
    if(val>=1000){
      str = 'Walks ${((val/1000) * pow(10, 2)).round() / pow(10, 2)} Km';
    }
    else {
      str = 'Walks $val m';
    }

    return str;
  }

  String convertDateTime(){
    int unixTimestamp = widget.unixDepart;
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(unixTimestamp * 1000);
    
    DateTime gmtPlus7DateTime = dateTime.toUtc().add(const Duration(hours: 7));

    String formattedTime = DateFormat('HH:mm').format(gmtPlus7DateTime);

    return formattedTime;
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: widget.status==1 ? lastHeight + 40 : 100.w,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left - Icon
          Container(
            width: 65.w,
            padding: EdgeInsets.only(
              left: 7.w,
              right: 7.w,
            ),
            child: widget.isWalking
                ? Icon(
                    Icons.directions_walk_outlined,
                    size: 24.w,
                  )
                : Column(
                    children: [
                      Icon(
                        Icons.train,
                        size: 24.w,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 3.w),
                        padding: EdgeInsets.all(2.w),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8.w)),
                          color: widget.widgetColor,
                        ),
                        child: Center(
                          child: Text(
                            widget.detail['transit_details']['line']['vehicle']
                                        ['name'] ==
                                    'Bus'
                                ? widget.detail['transit_details']['line']
                                    ['short_name']
                                : kode,
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

          // Line - Circle
          SizedBox(
            width: 14.w,
            height: double.infinity,
            child: Stack(
              fit: StackFit.passthrough,
              children: [
                // Line
                Positioned(
                  top: 7.w,
                  bottom: 7.w,
                  left: 0,
                  right: 0,
                  child: widget.isWalking
                      ? SizedBox(
                          child: CustomPaint(
                            painter: DashedLinePainter(
                                isVertical: true,
                                stroke: 3,
                                color: const Color.fromRGBO(222, 222, 222, 1)),
                          ),
                        )
                      : Container(
                          color: widget.widgetColor,
                        ),
                ),

                // Circle -----------------------------------
                if(widget.status==0 || widget.status==-1)
                  Positioned(
                    top: 0,
                    child: Container(
                      width: 14.w,
                      height: 14.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: widget.status==0 ? const Color.fromRGBO(27, 172, 71, 1) : widget.widgetColor,
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
                if(widget.status==1 || widget.status==-1) 
                  Positioned(
                    bottom: 0,
                    child: Container(
                      width: 14.w,
                      height: 14.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: widget.status==1 ? const Color.fromRGBO(27, 172, 71, 1) : widget.widgetColor,
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
                  widget.detail['html_instructions'],
                  key: textKey,
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w600,
                    fontSize: 18.sp,
                    color: Colors.black,
                  ),
                ),
                Text(
                  widget.isWalking ? convertDistance(widget.detail['distance']['value']) : '${widget.detail['transit_details']['num_stops']} Stops',
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
              convertDateTime(),
              style: TextStyle(
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w600,
                fontSize: 18.sp,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
