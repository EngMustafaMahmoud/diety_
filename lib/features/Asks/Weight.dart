// ignore_for_file: unnecessary_string_escapes, file_names

import 'package:flutter/material.dart';

import '../../Core/Colors.dart';
import '../../Core/Custom_Button.dart';
import 'Age.dart';
import 'Height.dart';

class Weight extends StatefulWidget {
  const Weight({super.key});

  @override
  State<Weight> createState() => _WeightState();
}

late TextEditingController weight;

class _WeightState extends State<Weight> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    weight = TextEditingController();
  }

  @override
  void dispose() {
    weight.dispose();
    super.dispose();
  }

  String? _validateWeight(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your weight';
    }
    final double weight = double.tryParse(value) ?? 0;
    if (weight < 50 || weight > 136) {
      return 'Weight should be between 50kg and 136kg';
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
              builder: (context) => const Height(),
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
                  "What's your Weight ?",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppColors.white,
                    fontSize: 30,
                  ),
                ),
                const SizedBox(
                  width: double.infinity,
                  height: 290,
                  child: Image(image: AssetImage('Images/weight.jpg')),
                ),
                TextFormField(
                  controller: weight,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: AppColors.text),
                  decoration: InputDecoration(
                    hintText: ' Enter your Weight',
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
                  validator: _validateWeight,
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
                        builder: (context) => const Age(),
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
