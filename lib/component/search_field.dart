import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: null,
      keyboardType: TextInputType.text,
      style: TextStyle(
        fontSize: 14.sp,
        fontFamily: 'Inter',
        fontWeight: FontWeight.normal,
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(16.w, 9.w, 10.w, 9.w),
        prefixIcon: const Icon(
          Icons.search,
          color: Color.fromRGBO(163, 173, 187, 1),
        ),
        hintText: 'Search',
        hintStyle: TextStyle(
          fontSize: 14.sp,
          fontFamily: 'Inter',
        ),
        enabledBorder: const OutlineInputBorder(
          // borderRadius: BorderRadius.all(Radius.circular(10.w)),
          borderSide: BorderSide(color: Colors.transparent, width: 0.0),
        ),
        // border: OutlineInputBorder(
        //   // borderRadius: BorderRadius.all(Radius.circular(10.w)),
        //   borderSide: BorderSide(color: Colors.red, width: 0.0),
        // ),
      ),
    );
  }
}
