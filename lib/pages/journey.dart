import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thesis_pubsconnect/component/ticket.dart';

class Journey extends StatefulWidget {
  final Map<String, dynamic>? dataTransport;
  final String startName;
  final String endName;
  const Journey(
      {super.key,
      this.dataTransport,
      required this.startName,
      required this.endName});

  @override
  // ignore: library_private_types_in_public_api
  _JourneyState createState() => _JourneyState();
}

class _JourneyState extends State<Journey> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(230, 242, 255, 1),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 70.w),
              child: Stack(
                fit: StackFit.passthrough,
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 149.w,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20.w),
                          bottomRight: Radius.circular(20.w)),
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color.fromRGBO(12, 68, 168, 1),
                          Color.fromRGBO(11, 135, 233, 1),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 55.w,
                    left: 10.w,
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 62.w,
                    child: Text(
                      'Your Journey',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w700,
                        fontSize: 21.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 100.w,
                    child: Container(
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
                                softWrap: true,
                              ),
                              SizedBox(
                                width: 200.w,
                                child: Text(
                                  widget.endName,
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                  softWrap: true,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.w),
                  Text(
                    'Best Route',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  for (int i = 0;
                      i < widget.dataTransport?['routes'].length;
                      i++)
                    Ticket(
                      startName: widget.startName,
                      endName: widget.endName,
                      transportData: widget.dataTransport?['routes'][i],
                      isHome: false,
                    )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
