// ignore_for_file: camel_case_types, file_names

import 'package:flutter/material.dart';

import 'Colors.dart';

class Custom_Button extends StatelessWidget {
  const Custom_Button({
    super.key,
    required this.text,
    required this.onPressed,
    this.height,
    this.width,
  });
  final String text;
  final Function() onPressed;
  final double? height;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (width) ?? double.infinity,
      height: (height) ?? 65,
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.button,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12))),
          child: Text(
            text,
            style: TextStyle(
                color: AppColors.text,
                fontSize: 20,
                fontWeight: FontWeight.w500),
          )),
    );
  }
}
