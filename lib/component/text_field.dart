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
                print(widget.select);
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
        ],
      ),
    );
  }

  
  // Widget radioField(){
  //   return
  // }
}
