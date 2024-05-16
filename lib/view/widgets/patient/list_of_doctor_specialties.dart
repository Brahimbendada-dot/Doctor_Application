import 'package:doctor_c/style/colors.dart';
import 'package:doctor_c/controller/patient/doctor_specialty_screen_controller.dart';
import 'package:flutter/material.dart';

Widget ListOfDoctorSpecialties(DoctorSpecialtyController controller) {
  return Container(
    height: 100,
    child: ListView.separated(
      separatorBuilder: (context, index) {
        return const SizedBox(
          width: 16,
        );
      },
      shrinkWrap: true,
      itemCount: controller.specialties.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: ((context, index) {
        return Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: controller.specialties[index].name ==
                        controller.specialty_name
                    ? const Border(
                        bottom: BorderSide(color: ColorTheme.primary, width: 3))
                    : null,
              ),
              child: TextButton(
                  onPressed: () {
                    controller
                        .changeSpecialty(controller.specialties[index].name);
                  },
                  child: Text(
                    '${controller.specialties[index].name}',
                    style: const TextStyle(
                      color: ColorTheme.black,
                      fontSize: 18,
                    ),
                  )),
            )
          ],
        );
      }),
    ),
  );
}
