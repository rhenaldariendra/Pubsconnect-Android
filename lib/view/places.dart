import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thesis_pubsconnect/api/place_api.dart';
import 'package:thesis_pubsconnect/component/place_card.dart';
import 'package:thesis_pubsconnect/pages/explore.dart';

class Places extends StatelessWidget {
  const Places({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'Explore Cities',
              style: TextStyle(
                fontFamily: 'Nunito',
                fontSize: 21.sp,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.left,
            ),
            GestureDetector(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: ((context) => const ExploreCities()))),
              child: Text(
                'View All',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
        // Text(
        //   'View All',
        //   style: TextStyle(
        //     fontFamily: 'Nunito',
        //     fontSize: 13.sp,
        //     fontWeight: FontWeight.w600,
        //     color: Theme.of(context).colorScheme.primary,
        //   ),
        // ),
        SizedBox(
          height: 16.w,
        ),
        FutureBuilder(
          future: PlaceAPI.getLocation(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              final data = snapshot.data;
              return SizedBox(
                // height: 160.w,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    for (int i = 0; i < 2; i++)
                      PlaceCard(
                        data: data['data'][i],
                      ),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              // return Text('Error: ${snapshot.error}');
              return SizedBox(
                height: 160.w,
                child: const Center(child: CircularProgressIndicator()),
              );
            } else {
              return SizedBox(
                height: 160.w,
                child: const Center(child: CircularProgressIndicator()),
              );
            }
          },
        ),
        SizedBox(
          height: 16.w,
        ),
      ],
    );
  }
}
