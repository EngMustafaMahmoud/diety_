// ignore_for_file: file_names, camel_case_types

import 'package:flutter/material.dart';

import '../../../Core/Colors.dart';

class Container_Goal extends StatelessWidget {
  const Container_Goal({
    super.key,
    required this.text,
    required this.onTap,
    required this.color,
  });
  final String text;
  final Function() onTap;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          width: double.infinity,
          height: 60,
          decoration: BoxDecoration(
            color: color,
            border: Border.all(color: AppColors.button, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(9),
            child: Row(
              children: [
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 20,
                    color: AppColors.text,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
