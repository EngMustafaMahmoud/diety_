// ignore_for_file: camel_case_types, file_names

import 'package:flutter/material.dart';

import 'Colors.dart';

class Countainer_activites extends StatelessWidget {
  const Countainer_activites({
    super.key,
    required this.title,
    required this.text,
    required this.height,
    required this.onTap,
    required this.color,
  });
  final String title;
  final String text;
  final double height;
  final Function() onTap;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        width: double.infinity,
        decoration: BoxDecoration(
            color: color,
            border: Border.all(color: AppColors.button, width: 2),
            borderRadius: BorderRadius.circular(15)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(color: AppColors.text, fontSize: 25)),
              Text(
                text,
                style: TextStyle(color: AppColors.text, fontSize: 17),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
