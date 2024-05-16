import 'package:doctor_c/style/colors.dart';
import 'package:flutter/material.dart';

Widget Button(String buttonName, Function()? onPressed) {
  Color buttonColor =
      buttonName == 'Cancel' ? ColorTheme.white : ColorTheme.primary;
  Color textColor =
      buttonName == 'Cancel' ? ColorTheme.black : ColorTheme.white;
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: buttonColor,
    ),
    onPressed: onPressed,
    child: Text(
      "${buttonName}",
      style: TextStyle(color: textColor),
    ),
  );
}
