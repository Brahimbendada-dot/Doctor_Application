import 'package:doctor_c/controller/doctor/profile_details_controller.dart';
import 'package:doctor_c/style/colors.dart';
import 'package:flutter/material.dart';

Widget HeaderProfileDetails(
    BuildContext context, ProfileDetailsController controller) {
  return Container(
    padding: const EdgeInsets.only(top: 25, left: 8, right: 8),
    width: MediaQuery.of(context).size.width,
    height: 200,
    decoration: const BoxDecoration(
        color: ColorTheme.primary,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(65), bottomRight: Radius.circular(65))),
    child: Column(
      children: [
        Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ))
          ],
        ),
        Container(
          height: 110,
          width: 110,
          decoration: BoxDecoration(
              color: ColorTheme.greyBackGround,
              shape: BoxShape.circle,
              border: Border.all(
                color: ColorTheme.white,
                width: 4,
              ),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(controller.doctor.photo),
              )),
        ),
      ],
    ),
  );
}
