// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

import '../../Core/Colors.dart';
import '../../Core/Custom_Button.dart';
import '../Asks/Activates.dart';
import 'wishes.dart';

class UserDitails extends StatelessWidget {
  const UserDitails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const Activates(),
              ));
            },
            icon: Icon(
              Icons.arrow_back,
              color: AppColors.text,
              size: 30,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Your Body Details',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppColors.white,
                  fontSize: 30,
                ),
              ),
              SizedBox(
                  width: 300,
                  height: 280,
                  child: Lottie.asset(
                    'Images/Ditails_Animation.json',
                  )),
              const Gap(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Your daily calorie needed :',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppColors.white,
                      fontSize: 19,
                    ),
                  ),
                  Text(
                    ' 3000',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppColors.white,
                      fontSize: 19,
                    ),
                  )
                ],
              ),
              const Gap(15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Body Mass Index (BMI) :',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppColors.white,
                      fontSize: 19,
                    ),
                  ),
                  Text(
                    'Obesity',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppColors.white,
                      fontSize: 19,
                    ),
                  )
                ],
              ),
              const Gap(15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Your Ideal Weight :',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppColors.white,
                      fontSize: 19,
                    ),
                  ),
                  Text(
                    '60',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppColors.white,
                      fontSize: 19,
                    ),
                  )
                ],
              ),
              const Gap(15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Your body fat :',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppColors.white,
                      fontSize: 19,
                    ),
                  ),
                  Text(
                    '20 %',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppColors.white,
                      fontSize: 19,
                    ),
                  )
                ],
              ),
              const Gap(50),
              Custom_Button(
                  width: 300,
                  text: 'My Plane',
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const Wishes(),
                    ));
                  })
            ],
          ),
        ),
      ),
    );
  }
}
