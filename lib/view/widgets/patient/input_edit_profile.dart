import 'package:doctor_c/style/colors.dart';
import 'package:flutter/material.dart';

Widget InputEditProfile(
    String initialValue,
    IconData icon,
    String hintText,
    String? Function(String?)? validator,
    void Function(String?)? onSaved) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
    height: 60,
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 3,
          blurRadius: 10,
          offset: Offset(0, 3), // changes position of shadow
        ),
      ],
    ),
    child: TextFormField(
      initialValue: initialValue,
      onSaved: onSaved,
      validator: validator,
      cursorColor: ColorTheme.black,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hintText,
        hintStyle: const TextStyle(color: ColorTheme.grey),
        prefixIcon: Icon(
          icon,
          color: ColorTheme.primary,
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(width: 2, color: ColorTheme.white)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(width: 2, color: ColorTheme.white)),
      ),
    ),
  );
}
