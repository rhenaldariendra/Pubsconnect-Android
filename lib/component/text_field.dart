// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatefulWidget {
  final String name;
  String select = '';
  final _fieldController = TextEditingController();
  CustomTextField({super.key, required this.name});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();

  String getText() {
    return _fieldController.text;
  }

  String getGender() {
    return select;
  }
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _validate = true;
  String errorMsg = 'Field is required';

  void validateInputPassword(event) {
    final alphanumeric = RegExp(r'^.{8}$');

    if (alphanumeric.hasMatch(widget._fieldController.text.trim()) == false) {
      setState(() {
        errorMsg = 'Password must be at least 8 characters';
        _validate = false;
      });
    } else {
      setState(() {
        _validate = true;
      });
    }
  }

  void validateRequired(event) {
    if (widget._fieldController.text.isEmpty) {
      setState(() {
        _validate = false;
      });
    } else {
      setState(() {
        _validate = true;
      });
    }
  }

  void validatePhoneNumber(event) {
    // r'^[0-9]+$'
    final alphanumeric = RegExp(r'^[0-9]+$');

    if (alphanumeric.hasMatch(widget._fieldController.text.trim()) == false) {
      setState(() {
        errorMsg = 'Check number format';
        _validate = false;
      });
    } else {
      setState(() {
        _validate = true;
      });
    }
  }

  List gender = [
    "Male",
    "Female",
    "Other"
  ];

  Row addRadioButton(int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 25.w,
          height: 25.w,
          child: Radio(
            // activeColor: Theme.of(context).primaryColor,
            value: gender[btnValue],
            groupValue: widget.select,
            onChanged: (value) {
              setState(() {
                widget.select = value;
              });
            },
          ),
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.bodySmall,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.name,
            style: Theme.of(context).textTheme.labelSmall,
          ),
          SizedBox(
            height: 8.w,
          ),
          if (widget.name == 'Password')
            TextField(
              controller: widget._fieldController,
              obscureText: true,
              onTapOutside: validateInputPassword,
              onChanged: validateInputPassword,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: 'Type something in here',
                hintStyle: Theme.of(context).textTheme.labelMedium,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.w)),
                  borderSide: BorderSide(width: 1.w, color: const Color.fromRGBO(245, 245, 245, 1)),
                ),
                contentPadding: EdgeInsets.fromLTRB(14.w, 12.w, 10.w, 12.w),
              ),
              style: Theme.of(context).textTheme.bodySmall,
            )
          else if (widget.name == 'Gender')
            Row(
              children: [
                addRadioButton(0, 'Male'),
                SizedBox(
                  width: 10.w,
                ),
                addRadioButton(1, 'Female'),
              ],
            )
          else if (widget.name == 'Phone')
            TextField(
              controller: widget._fieldController,
              onChanged: validatePhoneNumber,
              onTapOutside: validatePhoneNumber,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: 'Type something in here',
                hintStyle: Theme.of(context).textTheme.labelMedium,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.w)),
                  borderSide: BorderSide(width: 1.w, color: const Color.fromRGBO(245, 245, 245, 1)),
                ),
                contentPadding: EdgeInsets.fromLTRB(14.w, 12.w, 10.w, 12.w),
              ),
              style: Theme.of(context).textTheme.bodySmall,
            )
          else if (widget.name == 'Email')
            TextField(
              controller: widget._fieldController,
              keyboardType: TextInputType.emailAddress,
              onChanged: validateRequired,
              onTapOutside: validateRequired,
              decoration: InputDecoration(
                hintText: 'Type something in here',
                hintStyle: Theme.of(context).textTheme.labelMedium,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.w)),
                  borderSide: BorderSide(width: 1.w, color: const Color.fromRGBO(245, 245, 245, 1)),
                ),
                contentPadding: EdgeInsets.fromLTRB(14.w, 12.w, 10.w, 12.w),
              ),
              style: Theme.of(context).textTheme.bodySmall,
            )
          else
            TextField(
              controller: widget._fieldController,
              keyboardType: TextInputType.text,
              onChanged: validateRequired,
              onTapOutside: validateRequired,
              // on,
              decoration: InputDecoration(
                hintText: 'Type something in here',
                hintStyle: Theme.of(context).textTheme.labelMedium,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.w)),
                  borderSide: BorderSide(width: 1.w, color: const Color.fromRGBO(245, 245, 245, 1)),
                ),
                contentPadding: EdgeInsets.fromLTRB(14.w, 12.w, 10.w, 12.w),
              ),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          _validate
              ? SizedBox()
              : Text(
                  errorMsg,
                  style: TextStyle(
                    color: Color.fromRGBO(195, 29, 29, 1),
                    fontSize: 15.sp,
                  ),
                )
        ],
      ),
    );
  }

  // Widget radioField(){
  //   return
  // }
}
