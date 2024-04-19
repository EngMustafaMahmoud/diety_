// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../../../Core/Colors.dart';
import '../../User Plane/view/view/plane.dart';
import '../widget/AppBar.dart';
import '../widget/CustomSearchFood.dart';

class Lunch extends StatefulWidget {
  const Lunch({super.key});

  @override
  State<Lunch> createState() => _LunchState();
}

class _LunchState extends State<Lunch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBarFood(
        text: 'Lunch',
        onPressed: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const Plane(),
          ));
        },
      ),
      body: const Padding(
        padding: EdgeInsets.all(20),
        child: CustomSearchFood(),
      ),
    );
  }
}
