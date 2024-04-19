// ignore_for_file: file_names, avoid_print

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../Core/Colors.dart';
import '../../Core/Custom_Button.dart';
import 'Gender.dart';
import 'Weight.dart';

class Height extends StatefulWidget {
  const Height({super.key});

  @override
  State<Height> createState() => _HeightState();
}

late String height;

class _HeightState extends State<Height> {
  final _formKey = GlobalKey<FormState>(); // Add form key

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const Gender(),
            ));
          },
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.text,
            size: 30,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey, // Assign form key to the Form widget
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "What's your height ?",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppColors.white,
                    fontSize: 30,
                  ),
                ),
                const Gap(10),
                const SizedBox(
                  width: double.infinity,
                  height: 290,
                  child: Image(image: AssetImage('Images/height2.jpg')),
                ),
                const Gap(30),
                TextFormField(
                  onTap: () {},
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: AppColors.text),
                  decoration: InputDecoration(
                    hintText: ' Enter your Height',
                    hintStyle: TextStyle(fontSize: 20, color: AppColors.text),
                    border: const UnderlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: AppColors.button),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: AppColors.button),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your height';
                    }
                    final height = int.tryParse(value);
                    if (height == null || height < 60 || height > 200) {
                      return 'Height must be between 60cm and 200cm';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    height = value!;
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                Custom_Button(
                  text: 'Continue',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // Do something with the height value
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const Weight(),
                      ));
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
