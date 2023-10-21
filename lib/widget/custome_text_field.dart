

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../config/theme/app_colors.dart';


class AppTextField extends StatefulWidget {
  final IconData? postfixicon;
  final IconData? postfixicon1;
  final String hintText;
  bool ispasswordfield;
  bool isPassword;
  bool isEmail;

  TextEditingController cntrlr;
  final String? Function(String?)? validator;
  var onChange;

  AppTextField({
    Key? key,
    required this.ispasswordfield,
    this.postfixicon1,
    this.postfixicon,
    required this.hintText,
    required this.isEmail,
    required this.isPassword,
    required this.cntrlr,
    this.validator,
    this.onChange
  }) : super(key: key);

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: AppColors.textColor),
      cursorColor: AppColors.textColor,
      validator: widget.validator,
      onChanged: widget.onChange,
      obscureText: widget.isPassword,
      keyboardType:
      widget.isEmail ? TextInputType.emailAddress : TextInputType.text,
      decoration: InputDecoration(
        border: InputBorder.none,
        filled: true,
        fillColor: Colors.transparent,

        suffixIcon: Visibility(
          visible: widget.ispasswordfield,
          child: GestureDetector(
              onTap: () {
                setState(() {
                  widget.isPassword = !widget.isPassword;
                });
              },
              child: widget.isPassword
                  ? Icon(
                CupertinoIcons.eye_slash,
                color: AppColors.textColor,
              )
                  : Icon(
                CupertinoIcons.eye,
                color: AppColors.textColor,
              )),
        ),

        // contentPadding: const EdgeInsets.only(top: 15),
        hintText: widget.hintText,
        hintStyle: TextStyle(color: AppColors.textColor),
      ),
      controller: widget.cntrlr,
    );
  }
}