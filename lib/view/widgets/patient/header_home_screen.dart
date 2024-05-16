import 'package:doctor_c/controller/patient/home_controller.dart';
import 'package:doctor_c/style/colors.dart';
import 'package:doctor_c/view/widgets/patient/home_search_input.dart';
import 'package:flutter/material.dart';

Widget HedaerHomeScreen(BuildContext context, HomeScreenController controller) {
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.6,
                height: 100,
                // color: Colors.white,
                child: Center(
                  child: Text(
                    'Hi ${controller.patient.firstName} ${controller.patient.lastName} Lets Find Your Doctor',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () => controller.goToProfileDetails(),
              child: Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  border: Border.all(width: 2, color: ColorTheme.white),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(controller.patient.photo)),
                  color: ColorTheme.white,
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        HomeSearchInput(context, controller, 0.9)
      ],
    ),
  );
}
