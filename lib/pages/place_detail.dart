import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thesis_pubsconnect/api/place_api.dart';
import 'package:thesis_pubsconnect/component/loading.dart';

class PlaceDetail extends StatefulWidget {
  final dynamic detailId;
  final dynamic photo;
  const PlaceDetail({super.key, this.detailId, this.photo});

  @override
  State<PlaceDetail> createState() => _PlaceDetailState();
}

class _PlaceDetailState extends State<PlaceDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(252, 251, 252, 1),
      floatingActionButton: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20.w),
          backgroundColor: Colors.white.withOpacity(0.5),
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 10.w,
        ),
        label: const Text("Back"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      body: FutureBuilder(
        future: PlaceAPI.getDetail(widget.detailId),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data;
            return _buildPlaceDetail(data);
          } else {
            // return _buildPlaceDetail('data');
            return const Loading(height: double.infinity);
          }
        },
      ),
    );
  }

  Widget _buildPlaceDetail(data) {
    return Stack(
      children: [
        Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.only(left: 15.w, top: 30.w),
          height: 460.84.w,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: widget.photo != null ? NetworkImage(widget.photo['data'][0]['images']['original'] != null ? widget.photo['data'][0]['images']['original']['url'] : widget.photo['data'][0]['images']['small']['url']) : const AssetImage('assets/images/image_not_found.png') as ImageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        ListView(
          children: [
            Container(
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(18.w), topRight: Radius.circular(18.w))),
              margin: EdgeInsets.only(top: 420.w),
              padding: EdgeInsets.only(left: 25.w, right: 25.w, top: 16.w, bottom: 30.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data['name'],
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w600,
                      fontSize: 26.sp,
                      color: Colors.black,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 20.w,
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      SizedBox(
                        width: 250.w,
                        child: Text(
                          data['address_obj']['address_string'],
                          style: TextStyle(
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w300,
                            fontSize: 13.sp,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16.w,
                  ),
                  Text(
                    'About This Place',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w500,
                      fontSize: 18.sp,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    data.containsKey('description') ? data['description'] : "No Data",
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,
                      fontSize: 13.sp,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 18.w,
                  ),
                  SizedBox(
                    height: 50.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.w)),
                            padding: EdgeInsets.zero,
                            backgroundColor: const Color.fromRGBO(0, 118, 253, 1),
                            minimumSize: Size(50.w, double.infinity),
                            maximumSize: Size(50.w, double.infinity),
                          ),
                          child: Icon(
                            Icons.bookmark_add_outlined,
                            size: 25.w,
                            color: Colors.white,
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.w)),
                            padding: EdgeInsets.zero,
                            backgroundColor: const Color.fromRGBO(0, 118, 253, 1),
                            minimumSize: Size(235.w, double.infinity),
                            maximumSize: Size(250.w, double.infinity),
                          ),
                          onPressed: () {},
                          child: const Text('Get Directions'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
