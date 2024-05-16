import 'package:doctor_c/style/colors.dart';
import 'package:doctor_c/style/textStyle.dart';
import 'package:flutter/material.dart';

Widget ButtonProfile(
  IconData icon,
  String title,
  String subtitle,
  Function() onPressed,
) {
  return Container(
    margin: const EdgeInsets.only(top: 5, bottom: 10),
    width: double.infinity,
    height: 70,
    decoration: BoxDecoration(
      color: Colors.white, //ColorTheme.grey,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.4),
          spreadRadius: 3,
          blurRadius: 10,
          offset: Offset(0, 3), // changes position of shadow
        ),
      ],
    ),
    child: TextButton(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [
            Icon(
              icon,
              color: ColorTheme.primary,
            ),
            const SizedBox(
              width: 15,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: textTheme.booldTextBlack,
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(subtitle, style: textTheme.greyText),
              ],
            ),
          ]),
          const Icon(
            Icons.navigate_next_rounded,
            color: Colors.black,
            size: 40,
          )
        ],
      ),
    ),
  );
}
