// ignore_for_file: file_names, use_build_context_synchronously, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lottie/lottie.dart';
// ignore: duplicate_import
import 'package:google_sign_in/google_sign_in.dart';

import '../../Core/Colors.dart';
import '../../Core/Custom_Button.dart';
import '../Auth/Login.dart';
import 'Height.dart';

class Gender extends StatefulWidget {
  const Gender({super.key});

  @override
  State<Gender> createState() => _GenderState();
}

late String gender;
bool isMale = true;
CollectionReference users = FirebaseFirestore.instance.collection('users');
String uid = FirebaseAuth.instance.currentUser!.uid;
String? email = FirebaseAuth.instance.currentUser!.email;

class _GenderState extends State<Gender> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        leading: IconButton(
            onPressed: () async {
              GoogleSignIn googleSignIn = GoogleSignIn();
              googleSignIn.disconnect();
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const Login(),
              ));
            },
            icon: Icon(
              Icons.arrow_back,
              color: AppColors.text,
              size: 30,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Choose your gender.. ",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppColors.white,
                  fontSize: 30,
                ),
              ),
              SizedBox(
                  height: 280,
                  width: double.infinity,
                  child: Lottie.asset(('Images/Gender.json'))),
              SizedBox(
                width: 320,
                height: 80,
                child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isMale = true;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        side: BorderSide(color: AppColors.button, width: 2),
                        backgroundColor:
                            (isMale) ? AppColors.button : AppColors.background,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12))),
                    child: Text(
                      'Male',
                      style: TextStyle(
                          color: AppColors.text,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    )),
              ),
              const Gap(15),
              SizedBox(
                width: 320,
                height: 80,
                child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isMale = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        side: BorderSide(color: AppColors.button, width: 2),
                        backgroundColor:
                            (!isMale) ? AppColors.button : AppColors.background,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12))),
                    child: Text(
                      'Female',
                      style: TextStyle(
                          color: AppColors.text,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    )),
              ),
              const Gap(30),
              Custom_Button(
                  text: 'Continue',
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const Height(),
                    ));
                  })
            ],
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
    );
  }
}
