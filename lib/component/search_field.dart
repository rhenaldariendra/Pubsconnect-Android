import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thesis_pubsconnect/pages/search_res.dart';

// ignore: must_be_immutable
class SearchField extends StatelessWidget {
  final bool isHome;
  VoidCallback? localSearch;
  TextEditingController? searchResController;
  SearchField(
      {super.key,
      required this.isHome,
      this.localSearch,
      this.searchResController});
  TextEditingController test = TextEditingController();

  String getText() {
    return test.text;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlignVertical: TextAlignVertical.center,
      controller: isHome ? test : searchResController,
      keyboardType: TextInputType.text,
      style: TextStyle(
        fontSize: 16.sp,
        fontFamily: 'Inter',
        fontWeight: FontWeight.normal,
      ),
      onSubmitted: (val) {
        if (isHome == true) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (builder) => SearchResult(searchValue: val),
            ),
          );
        } else {
          localSearch!();
        }
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(16.w, 9.w, 10.w, 9.w),
        prefixIcon: Icon(
          Icons.search,
          color: const Color.fromRGBO(163, 173, 187, 1),
          size: 25.w,
        ),
        fillColor: Colors.white,
        filled: true,
        hintText: 'Search',
        hintStyle: TextStyle(
          fontSize: 16.sp,
          fontFamily: 'Inter',
        ),
        enabledBorder: const OutlineInputBorder(
          // borderRadius: BorderRadius.all(Radius.circular(10.w)),
          borderSide: BorderSide(color: Colors.transparent, width: 0.0),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.w)),
          borderSide: const BorderSide(color: Colors.transparent, width: 0.0),
        ),
      ),
    );
  }
}
