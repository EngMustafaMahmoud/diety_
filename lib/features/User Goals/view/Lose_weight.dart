// ignore_for_file: file_names, avoid_print
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../Core/Colors.dart';
import '../../../Core/Custom_Button.dart';
import '../../Asks/Gender.dart';
import '../../User Plane/view/view/plane.dart';
import '../Widget/Container_Goal.dart';
import 'wishes.dart';

// ignore: camel_case_types
class lose_Weight extends StatefulWidget {
  const lose_Weight({super.key});

  @override
  State<lose_Weight> createState() => _lose_WeightState();
}

List<bool> isSelected = List.generate(4, (index) => false);
List<String> loseGoals = [
  'Lose 0.25 Kg per week',
  'Lose 0.5 Kg per week',
  'Lose 0.75 Kg per week',
  'Lose 1 Kg per week',
];
late String lose;

// ignore: camel_case_types
class _lose_WeightState extends State<lose_Weight> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const Wishes(),
              ));
            },
            icon: Icon(
              Icons.arrow_back,
              color: AppColors.text,
              size: 30,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'What is your weekly goal',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: AppColors.white,
                fontSize: 30,
              ),
            ),
            const Gap(60),
            Container_Goal(
              onTap: () {
                setState(() {
                  isSelected = [true, false, false, false];
                });
              },
              color: isSelected[0] ? AppColors.button : AppColors.background,
              text: 'Lose 0.25 Kg per week',
            ),
            const Gap(15),
            Container_Goal(
              onTap: () {
                setState(() {
                  isSelected = [false, true, false, false];
                });
              },
              color: isSelected[1] ? AppColors.button : AppColors.background,
              text: 'Lose 0.5 Kg per week (Recommended)',
            ),
            const Gap(15),
            Container_Goal(
              onTap: () {
                setState(() {
                  isSelected = [false, false, true, false];
                });
              },
              color: isSelected[2] ? AppColors.button : AppColors.background,
              text: 'Lose 0.75 Kg per week',
            ),
            const Gap(15),
            Container_Goal(
              onTap: () {
                setState(() {
                  isSelected = [false, false, false, true];
                });
              },
              color: isSelected[3] ? AppColors.button : AppColors.background,
              text: 'Lose 1 Kg per week',
            ),
            const Gap(40),
            Custom_Button(
                width: double.infinity,
                text: 'Continue',
                onPressed: () {
                  goalUpdate();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const Plane(),
                  ));
                })
          ],
        ),
      ),
    );
  }

  Future<void> goalSelection() async {
    for (int i = 0; i < isSelected.length; i++) {
      if (isSelected[i] == true) {
        lose = loseGoals[i];
        break;
      }
    }
  }

  Future<void> goalUpdate() async {
    String wishes = isLose ? 'lose' : 'gain';
    goalSelection();
    return users
        .doc(uid)
        .update({"wishes": wishes, "goal": lose})
        .then((value) => print('user updated'))
        .catchError((error) => print(error));
  }
}
