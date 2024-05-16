
import 'package:doctor_c/style/colors.dart';
import 'package:flutter/material.dart';

Widget InputField(
    BuildContext context,
    TextEditingController controller,
    String hintText,
    IconData icon,
    String? Function(String?)? validator,
    TextInputType keyboardType) {
  return Container(
    margin: const EdgeInsets.only(bottom: 15, left: 10, right: 10),
    width: MediaQuery.of(context).size.width,
    height: 50,
    decoration: BoxDecoration(
      color: ColorTheme.greyBackGround,
      borderRadius: BorderRadius.circular(20),
    ),
    child: TextFormField(
      validator: validator,
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: ColorTheme.grey),
        prefixIcon: Icon(
          icon,
          color: ColorTheme.grey,
        ),
        border: InputBorder.none,
      ),
    ),
  );
}
