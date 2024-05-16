import 'package:doctor_c/style/colors.dart';
import 'package:doctor_c/style/textStyle.dart';
import 'package:flutter/material.dart';

Widget ContainerProfileDetails(
    BuildContext context, IconData icon, String subtitle, String title) {
  return Container(
    padding: const EdgeInsets.only(left: 8, right: 8),
    margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
    width: MediaQuery.of(context).size.width,
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
      color: ColorTheme.white,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      children: [
        Icon(icon),
        const SizedBox(
          width: 15,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title, style: textTheme.booldTextBlack),
            const SizedBox(height: 3),
            Text(subtitle, style: textTheme.greyText),
          ],
        )
      ],
    ),
  );
}
