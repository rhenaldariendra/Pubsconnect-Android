import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thesis_pubsconnect/component/semi_ciruclar_painter.dart';
import 'package:thesis_pubsconnect/component/dashed_line_painter.dart';
import 'package:thesis_pubsconnect/pages/trip_detail.dart';

class Ticket extends StatefulWidget {
  final Map<String, dynamic> transportData;
  final String startName;
  final String endName;
  const Ticket({super.key, required this.transportData, required this.startName, required this.endName});

  @override
  State<Ticket> createState() => _TicketState();
}

class _TicketState extends State<Ticket> {
  String imageAsset = 'assets/images/transport/angkutan_tj.png';
  String imageName = 'Transjakarta';
  Color buttonColor = const Color.fromRGBO(50, 128, 195, 1);

  String btnColor = '';
  List<Map<String, dynamic>> detailTransit = []; //[ {'kode': 'asdasd', 'provider': ''}]
  void checkProvider(String check) {
    // steps -> transitdetails -> line -> agencies

    // PT. Transportasi Jakarta - TJ -> me
    // PT. MRT Jakarta - MRT -> ji
    // PT. JakLingko Indonesia - Mikrolet -> ku
    // PT. LRT Jakarta - LRT -> hi
    // PT. Kereta Commuter Indonesia - KRL -> bi

    if (check.contains('Transportasi Jakarta')) {
      setState(() {
        imageAsset = 'assets/images/transport/angkutan_tj.png';
        imageName = 'Transjakarta';
        // buttonColor = const Color.fromRGBO(50, 128, 195, 1);
      });
    } else if (check.contains('MRT')) {
      setState(() {
        imageAsset = 'assets/images/transport/angkutan_mrt.png';
        imageName = 'Mass Rapid Transit';
        // buttonColor = const Color.fromRGBO(36, 44, 92, 1);
      });
    } else if (check.contains('Angkot')) {
      setState(() {
        imageAsset = 'assets/images/transport/angkutan_mikrotrans.png';
        imageName = 'Mikrotrans';
        // buttonColor = const Color.fromRGBO(156, 208, 232, 1);
      });
    } else if (check.contains('LRT')) {
      setState(() {
        imageAsset = 'assets/images/transport/angkutan_lrt.png';
        imageName = 'Light Rail Transit';
        // buttonColor = const Color.fromRGBO(230, 231, 232, 1);
      });
    } else {
      setState(() {
        imageAsset = 'assets/images/transport/angkutan_kaicommuter.png';
        imageName = 'Commuter Line';
        // buttonColor = const Color.fromRGBO(236, 28, 36, 1);
      });
    }
  }

  Color colorCheck(check) {
    if (check.contains('Transportasi Jakarta')) {
      return const Color.fromRGBO(50, 128, 195, 1);
    } else if (check.contains('MRT')) {
      return const Color.fromRGBO(36, 44, 92, 1);
    } else if (check.contains('Angkot')) {
      return const Color.fromRGBO(156, 208, 232, 1);
    } else if (check.contains('LRT')) {
      return const Color.fromRGBO(230, 231, 232, 1);
    } else if (check.contains('Kereta')) {
      return const Color.fromRGBO(236, 28, 36, 1);
    } else {
      return const Color.fromRGBO(230, 242, 255, 1);
    }
  }

  void mappingTransport() {
    for (var element in widget.transportData['legs'][0]['steps']) {
      if (element['travel_mode'] != 'WALKING') {
        Map<String, dynamic> temp = {
          // element.con
          'kode': element['transit_details']['line'].containsKey('short_name') ? element['transit_details']['line']['short_name'] : element['transit_details']['line']['name'],
          'provider': element['transit_details']['line']['agencies'][0]['name'],
          'color': colorCheck(element['transit_details']['line']['agencies'][0]['name']),
        };
        detailTransit.add(temp);
      }
    }
    if (detailTransit.isNotEmpty) {
      checkProvider(detailTransit[0]['provider']!);
    }
  }

  @override
  void initState() {
    mappingTransport();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (builder) => TripDetail(
              startName: widget.startName,
              endName: widget.endName,
            ),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        height: 145.w,
        // padding: EdgeInsets.only(left: 16.w, right: 16.w),
        margin: EdgeInsets.symmetric(vertical: 10.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.w)),
          color: Colors.white,
        ),
        child: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              top: 84.w,
              child: Container(
                height: 1,
                child: CustomPaint(
                  painter: DashedLinePainter(),
                ),
              ),
            ),
            Positioned(
              top: 75.w,
              right: -9.w,
              child: Transform.rotate(
                angle: -math.pi / 2,
                child: Container(
                  width: 18.w,
                  height: 18.w,
                  child: CustomPaint(
                    painter: SemiCirclePainter(),
                    // child: ,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 75.w,
              left: -9.w,
              child: Transform.rotate(
                angle: math.pi / 2,
                child: Container(
                  width: 18.w,
                  height: 18.w,
                  child: CustomPaint(
                    painter: SemiCirclePainter(),
                    // child: ,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 16.w,
              left: 16.w,
              right: 16.w,
              child: Container(
                width: 152.w,
                height: 36.w,
                child: Row(
                  children: [
                    Image.asset(imageAsset),
                    SizedBox(
                      width: 8.w,
                    ),
                    Text(
                      imageName,
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w600,
                        fontSize: 20.sp,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 57.w,
              left: 16.w,
              right: 16.w,
              child: SizedBox(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    for (int i = 0; i < detailTransit.length; i++)
                      Flexible(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.only(right: 6.w),
                          height: 20.w,
                          child: ElevatedButton(
                            onPressed: () {
                              checkProvider(detailTransit[i]['provider']!);
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.fromLTRB(5.w, 0, 5.w, 0),
                              backgroundColor: detailTransit[i]['color'],
                              minimumSize: Size(34.w, 15.w),
                              maximumSize: Size(100.w, 15.w),
                            ),
                            child: Center(
                              child: Text(
                                detailTransit[i]['kode']!,
                                style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 10.sp,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 105.w,
              left: 16.w,
              right: 16.w,
              child: SizedBox(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Travel Time: ${widget.transportData['legs'][0]['duration']['text']}',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w600,
                        fontSize: 13.sp,
                        letterSpacing: 0,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      widget.transportData.containsKey('fare') ? widget.transportData['fare']['text'] : '-',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w700,
                        fontSize: 16.sp,
                        color: const Color.fromRGBO(44, 44, 44, 1),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
