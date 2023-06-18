import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFieldLogo extends StatefulWidget {
  final _fieldController = TextEditingController();
  final IconData iconPath;
  final String placeholder;
  final bool isPassword;
  CustomTextFieldLogo({super.key, required this.iconPath, required this.placeholder, required this.isPassword});

  @override
  State<CustomTextFieldLogo> createState() => _CustomTextFieldLogoState();

  String getText() {
    return _fieldController.text;
  }
}

class _CustomTextFieldLogoState extends State<CustomTextFieldLogo> {
  dynamic _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          widget.iconPath,
          size: 24.w,
        ),
        SizedBox(
          width: 16.w,
        ),
        Expanded(
          child: TextField(
            controller: widget._fieldController,
            obscureText: widget.isPassword == true ? _isObscure : false,
            decoration: InputDecoration(
              suffixIcon: widget.isPassword
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                      icon: Icon(
                        _isObscure ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                        size: 24.w,
                      ),
                    )
                  : null,
              hintText: widget.placeholder,
              hintStyle: Theme.of(context).textTheme.labelMedium,
              contentPadding: EdgeInsets.fromLTRB(0, 12.w, 10.w, 12.w),
            ),
            style: TextStyle(
              fontSize: 16.sp,
              fontFamily: 'PlusJakartaSans',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        // if (widget.isPassword == false)
        // Icon(
        //   Icons.remove_red_eye_outlined,
        //   size: 24.w,
        // ),
      ],
    );
  }
}
