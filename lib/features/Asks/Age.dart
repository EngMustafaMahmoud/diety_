// ignore_for_file: file_names
import 'package:flutter/material.dart';
import '../../Core/Colors.dart';
import '../../Core/Custom_Button.dart';
import 'Activates.dart';

import 'Weight.dart';

class Age extends StatefulWidget {
  const Age({super.key});

  @override
  State<Age> createState() => _AgeState();
}

late TextEditingController age;

class _AgeState extends State<Age> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    age = TextEditingController();
  }

  @override
  void dispose() {
    age.dispose();
    super.dispose();
  }

  String? _validateAge(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your age';
    }
    final int age = int.tryParse(value) ?? 0;
    if (age < 18 || age > 60) {
      return 'Age should be between 18 and 60';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const Weight(),
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
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "What's your age ?",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppColors.white,
                    fontSize: 30,
                  ),
                ),
                const SizedBox(
                  width: double.infinity,
                  height: 290,
                  child: Image(image: AssetImage('Images/age.jpg')),
                ),
                TextFormField(
                  controller: age,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: AppColors.text),
                  decoration: InputDecoration(
                    hintText: 'Enter Your age',
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
                  validator: _validateAge,
                ),
                const SizedBox(
                  height: 30,
                ),
                Custom_Button(
                  text: 'Continue',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // Form is valid, proceed to the next step
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const Activates(),
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
