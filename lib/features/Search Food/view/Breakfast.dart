// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../../../Core/Colors.dart';
import '../../User Plane/view/view/plane.dart';
import '../widget/AppBar.dart';
import '../widget/CustomSearchFood.dart';

class Breakfast extends StatefulWidget {
  const Breakfast({super.key});

  @override
  State<Breakfast> createState() => _BreakfastState();
}

class _BreakfastState extends State<Breakfast> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBarFood(
        text: 'Breakfast',
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
