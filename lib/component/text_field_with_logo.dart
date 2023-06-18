import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFieldLogo extends StatefulWidget {
  final _fieldController = TextEditingController();
  final IconData iconPath;
  CustomTextFieldLogo({super.key, required this.iconPath});

  @override
  State<CustomTextFieldLogo> createState() => _CustomTextFieldLogoState();

  String getText() {
    return _fieldController.text;
  }
}

class _CustomTextFieldLogoState extends State<CustomTextFieldLogo> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          widget.iconPath,
          // Icons.alternate_email_rounded
          size: 24.w,
        ),
        SizedBox(
          width: 16.w,
        ),
        Expanded(
          child: TextField(
            controller: widget._fieldController,
            style: TextStyle(
              fontSize: 16.sp,
              fontFamily: 'PlusJakartaSans',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
