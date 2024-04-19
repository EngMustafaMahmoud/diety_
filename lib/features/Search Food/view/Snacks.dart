// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../../../Core/Colors.dart';
import '../../User Plane/view/view/plane.dart';
import '../widget/AppBar.dart';
import '../widget/CustomSearchFood.dart';

class Snacks extends StatefulWidget {
  const Snacks({super.key});

  @override
  State<Snacks> createState() => _SnacksState();
}

class _SnacksState extends State<Snacks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBarFood(
        text: 'Snacks/Other',
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
