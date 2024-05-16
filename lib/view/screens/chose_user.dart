import 'package:doctor_c/controller/chose_user_controller.dart';
import 'package:doctor_c/style/textStyle.dart';
import 'package:doctor_c/view/widgets/doctor/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChoseUser extends StatelessWidget {
  const ChoseUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ChoseUserController>(
          init: ChoseUserController(),
          builder: (controller) {
            return Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Choose your status',
                    style: textTheme.booldTextBlack,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                      width: 250,
                      child: Button(
                          "Doctor", () => controller.goToDoctorApplication())),
                  Container(
                      width: 250,
                      child: Button("Patient",
                          () => controller.goToPatientApplication())),
                ],
              ),
            );
          }),
    );
  }
}
