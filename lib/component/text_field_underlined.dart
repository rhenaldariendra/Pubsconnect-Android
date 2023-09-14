// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFieldUnderlined extends StatefulWidget {
  final _fieldController = TextEditingController();
  String value;
  final String titles;
  CustomTextFieldUnderlined({super.key, required this.value, required this.titles});

  @override
  State<CustomTextFieldUnderlined> createState() => _CustomTextFieldUnderlinedState();

  String getText() {
    return _fieldController.text;
  }
}

class _CustomTextFieldUnderlinedState extends State<CustomTextFieldUnderlined> {
  @override
  void initState() {
    widget._fieldController.text = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.titles,
          style: TextStyle(
            fontFamily: 'PlusJakartaSans',
            fontWeight: FontWeight.w600,
            fontSize: 12.sp,
            color: const Color.fromRGBO(84, 104, 129, 1),
          ),
        ),
        TextField(
          keyboardType: widget.titles == 'Phone Number' ? TextInputType.phone : TextInputType.name,
          controller: widget._fieldController,
          enabled: widget.titles == 'Email' || widget.titles == 'Gender' ? false : true,
          style: TextStyle(
            fontSize: 16.sp,
            fontFamily: 'PlusJakartaSans',
            fontWeight: FontWeight.w600,
            color: widget.titles == 'Email' || widget.titles == 'Gender' ? Colors.grey.shade400 : Colors.black,
          ),
        ),
        SizedBox(
          height: 10.w,
        ),
      ],
    );
  }
}
