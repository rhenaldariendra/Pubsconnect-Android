import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thesis_pubsconnect/api/place_api.dart';
import 'package:thesis_pubsconnect/component/place_card.dart';
import 'package:thesis_pubsconnect/component/search_field.dart';
import 'package:thesis_pubsconnect/component/loading.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

class SearchResult extends StatefulWidget {
  final String searchValue;
  const SearchResult({super.key, required this.searchValue});

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  final TextEditingController _controller = TextEditingController();
  bool _isLoading = false;
  List<Map<String, dynamic>> placeItem = [];
  List<TrackSize> arrRow = [auto];

  void localSearch() async {
    setState(() {
      _isLoading = true;
      placeItem = [];
      arrRow = [auto];
    });
    Map<String, dynamic> test =
        await PlaceAPI.getSearchResult(_controller.text);
    for (var items in test['data']) {
      setState(() {
        arrRow.add(auto);
        placeItem.add(items);
      });
    }
    print(test);

    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(24.w, 12.w, 24.w, 24.w),
            width: double.infinity,
            height: 130.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.w),
                bottomRight: Radius.circular(20.w),
              ),
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(12, 68, 168, 1),
                  Color.fromRGBO(11, 135, 233, 1),
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white,
                        size: 15.w,
                      ),
                    ),
                    SizedBox(width: 80.w),
                    Text(
                      'Search Result',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w700,
                        fontSize: 21.sp,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                SearchField(
                  isHome: false,
                  localSearch: localSearch,
                  searchResController: _controller,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10.w, 20.w, 10.w, 0),
            child: FutureBuilder(
              future: PlaceAPI.getSearchResult(widget.searchValue),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  final data = snapshot.data;
                  for (var item in data['data']) {
                    arrRow.add(auto);
                    placeItem.add(item);
                  }

                  return _isLoading
                      ? Loading(height: 300.w)
                      : placeItem.isEmpty
                          ? Text(
                              'No Result',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.w700,
                                fontSize: 32.sp,
                                color: Colors.black,
                              ),
                            )
                          : LayoutGrid(
                              columnSizes: [1.fr, 1.fr],
                              rowGap: 16.w,
                              columnGap: 24.w,
                              rowSizes: arrRow,
                              children: [
                                for (var item in placeItem)
                                  PlaceCard(
                                    data: item,
                                  )
                              ],
                            );
                } else {
                  return Loading(
                    height: 300.w,
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
