import 'package:doctor_c/style/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget InputPassword(
  BuildContext context,
  TextEditingController controller,
  String hintText,
  IconData icon,
  String? Function(String?)? validator,
  bool obscureText,
  IconData eye,
  Function()? onPressed,
) {
  return Container(
    margin: const EdgeInsets.only(bottom: 15, left: 10, right: 10),
    width: MediaQuery.of(context).size.width,
    height: 50,
    decoration: BoxDecoration(
      color: ColorTheme.greyBackGround,
      borderRadius: BorderRadius.circular(20),
    ),
    child: TextFormField(
      obscureText: obscureText,
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: ColorTheme.grey),
        prefixIcon: Icon(
          icon,
          color: ColorTheme.grey,
        ),
        suffixIcon: IconButton(
          icon: Icon(eye),
          onPressed: onPressed,
        ),
        border: InputBorder.none,
      ),
    ),
  );
}
