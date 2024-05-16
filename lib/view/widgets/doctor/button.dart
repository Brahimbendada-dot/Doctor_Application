import 'package:doctor_c/style/colors.dart';
import 'package:flutter/material.dart';

Widget Button(String buttonName, Function()? onPressed) {
  Color buttonColor = ColorTheme.primary;
  Color textColor = ColorTheme.white;

  if (buttonName == 'Accept') {
    buttonColor = ColorTheme.grenBackground;
    textColor = ColorTheme.green;
  }
  ;
  if (buttonName == 'Reject') {
    textColor = ColorTheme.orange;
    buttonColor = ColorTheme.orangeBackground;
  }

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
