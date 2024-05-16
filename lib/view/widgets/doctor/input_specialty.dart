import 'package:doctor_c/controller/doctor/Auth_controller/createAccount_controller.dart';
import 'package:doctor_c/style/colors.dart';

import 'package:flutter/material.dart';

Widget InputSpecialty(
    BuildContext context, CreateAccountController controller) {
  return Container(
    padding: const EdgeInsets.all(10),
    margin: const EdgeInsets.only(bottom: 15, left: 10, right: 10),
    width: MediaQuery.of(context).size.width,
    height: 50,
    decoration: BoxDecoration(
      color: ColorTheme.greyBackGround,
      borderRadius: BorderRadius.circular(20),
    ),
    child: DropdownButton(
      underline: Container(),
      isExpanded: true,
      hint: const Text(
        "Chose Specialty",
        style: TextStyle(color: ColorTheme.grey),
      ),
      items: controller.specialties
          .map((e) => DropdownMenuItem(
                child: Text(
                  e.name,
                  style: TextStyle(color: ColorTheme.primary),
                ),
                value: e.name,
              ))
          .toList(),
      onChanged: (val) => controller.setSpecialty(val),
      value: controller.specialty,
    ),
  );
}
