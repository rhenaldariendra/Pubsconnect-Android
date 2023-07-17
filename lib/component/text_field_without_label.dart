import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFieldWithoutLabel extends StatefulWidget {
  final String hintText;
  final _fieldController = TextEditingController();
  final VoidCallback onChangedValue;
  CustomTextFieldWithoutLabel({super.key, required this.hintText, required this.onChangedValue});

  @override
  State<CustomTextFieldWithoutLabel> createState() => _CustomTextFieldWithoutLabelState();

  String getText() {
    return _fieldController.text;
  }
}

class _CustomTextFieldWithoutLabelState extends State<CustomTextFieldWithoutLabel> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (val) {
        widget.onChangedValue;
      },
      textInputAction: TextInputAction.go,
      controller: widget._fieldController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: Theme.of(context).textTheme.labelMedium,
        fillColor: const Color.fromRGBO(248, 248, 248, 1),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.w)),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.fromLTRB(14.w, 8.w, 10.w, 8.w),
      ),
      style: Theme.of(context).textTheme.bodySmall,
    );
  }
}
