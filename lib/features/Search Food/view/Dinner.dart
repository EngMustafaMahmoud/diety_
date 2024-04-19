// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../../../Core/Colors.dart';
import '../../User Plane/view/view/plane.dart';
import '../widget/AppBar.dart';
import '../widget/CustomSearchFood.dart';

class Dinner extends StatefulWidget {
  const Dinner({super.key});

  @override
  State<Dinner> createState() => _DinnerState();
}

class _DinnerState extends State<Dinner> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBarFood(
        text: 'Dinner',
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
