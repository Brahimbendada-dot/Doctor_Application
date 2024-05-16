import 'package:doctor_c/model/specialty.dart';
import 'package:doctor_c/style/colors.dart';
import 'package:doctor_c/style/textStyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget SpecialtyWidget(Specialty specialty) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
            color: ColorTheme.greyBackGround,
            shape: BoxShape.circle,
            border: Border.all(
              color: ColorTheme.primary,
              width: 2,
            ),
            image: DecorationImage(
              image: NetworkImage(
                "${specialty.image}",
              ),
            )),
      ),
      const SizedBox(
        height: 5,
      ),
      Text(
        '${specialty.name}',
        textAlign: TextAlign.start,
        style: textTheme.greyText,
      ),
    ],
  );
}
