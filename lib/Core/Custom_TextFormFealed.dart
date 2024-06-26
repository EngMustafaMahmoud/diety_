// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'Colors.dart';

class CusomTextFormFeald extends StatelessWidget {
  const CusomTextFormFeald({
    super.key,
    required this.lable,
    required this.prefixIcon,
    this.suffixIcon,
    this.obscureText,
    this.validator,
    this.mycontroller,
    this.onTap,
  });
  final String lable;
  final IconData prefixIcon;
  final Widget? suffixIcon;
  final bool? obscureText;
  final String? Function(String?)? validator;
  final TextEditingController? mycontroller;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      controller: mycontroller,
      obscureText: obscureText ?? false,
      validator: validator,
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(color: AppColors.text),
      decoration: InputDecoration(
          suffixIcon: suffixIcon ?? const SizedBox(),
          prefixIcon: Icon(
            prefixIcon,
            color: AppColors.text,
          ),
          label: Text(
            lable,
            style: TextStyle(fontSize: 18, color: AppColors.text),
          ),
          border: const UnderlineInputBorder(),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: AppColors.button)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: AppColors.button)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Colors.red)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Colors.red))),
    );
  }
}
