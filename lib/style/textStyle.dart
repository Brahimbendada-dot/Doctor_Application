import 'package:doctor_c/style/colors.dart';
import 'package:flutter/material.dart';

class textTheme {
  static const TextStyle booldTextBlack = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: ColorTheme.black,
  );
  static const TextStyle booldTextWhite = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: ColorTheme.white,
  );
  static const TextStyle greyText = TextStyle(
    fontSize: 12,
    color: ColorTheme.grey,
  );
  static const capitalText = TextStyle(
      color: ColorTheme.grey, fontSize: 16, fontWeight: FontWeight.bold);
  static const profileText =
      TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold);
  static const profileSubText = TextStyle(
      fontSize: 14, color: ColorTheme.grey, fontWeight: FontWeight.bold);
}
