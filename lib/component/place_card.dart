import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thesis_pubsconnect/api/place_api.dart';
import 'package:thesis_pubsconnect/pages/place_detail.dart';

// ignore: must_be_immutable
class PlaceCard extends StatelessWidget {
  final dynamic data;
  PlaceCard({super.key, this.data});
  late dynamic photos;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlaceDetail(
              detailId: data['location_id'],
              photo: photos,
            ),
          ),
        );
      },
      child: Container(
        width: 160.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8.w)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              offset: Offset(0, 4.w),
              spreadRadius: 0,
              blurRadius: 4,
            ),
          ],
        ),
        padding: EdgeInsets.all(10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _getPhoto(),
            SizedBox(
              height: 8.w,
            ),
            SizedBox(
              width: 135.w,
              child: Text(
                // data['name'] != null ? data['name'] : 'No Data',
                data['name'] ?? 'No Data',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w700,
                  fontSize: 14.sp,
                  color: Colors.black,
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.location_on_outlined,
                ),
                Flexible(
                  child: Text(
                    // data['address_obj']['street1'] != null ? data['address_obj']['street1'] : 'No Data',
                    data['address_obj']['street1'] ?? 'No Data',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.normal,
                      fontSize: 10.sp,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _getPhoto() {
    return FutureBuilder(
      future: PlaceAPI.getPhoto(data['location_id']),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data;
          // print(data);
          if (snapshot.data['data'] != null && snapshot.data['data'].isNotEmpty) {
            photos = data;
            // print(photos);
            return SizedBox(
              width: 135.w,
              height: 180.w,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6.w),
                child: Image.network(
                  data['data'][0]['images']['original'] != null ? data['data'][0]['images']['original']['url'] : data['data'][0]['images']['small']['url'],
                  fit: BoxFit.fitHeight,
                ),
              ),
            );
          } else {
            photos = null;
            return SizedBox(
              width: 135.w,
              height: 180.w,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6.w),
                child: Image.asset(
                  'assets/images/image_not_found.png',
                  fit: BoxFit.fitHeight,
                ),
              ),
            );
          }
        } else if (snapshot.hasError) {
          photos = null;
          return SizedBox(
            width: 135.w,
            height: 180.w,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6.w),
              child: Image.asset(
                'assets/images/image_not_found.png',
                fit: BoxFit.fitHeight,
              ),
            ),
          );
        } else {
          photos = null;
          return SizedBox(
            width: 126.w,
            height: 180.w,
            child: const Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}
