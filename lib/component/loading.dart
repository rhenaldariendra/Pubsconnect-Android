import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  final double height;
  const Loading({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
