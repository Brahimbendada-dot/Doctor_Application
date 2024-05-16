import 'package:doctor_c/controller/patient/doctor_details_controller.dart';
import 'package:doctor_c/style/colors.dart';
import 'package:doctor_c/style/textStyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget HeaderDoctorDetails(
    BuildContext context, DoctorDetailsController controller) {
  return Container(
    padding: const EdgeInsets.only(top: 25, left: 8, right: 8),
    width: MediaQuery.of(context).size.width,
    decoration: const BoxDecoration(
        color: ColorTheme.primary,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(65), bottomRight: Radius.circular(65))),
    child: SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: ColorTheme.white,
                  ))
            ],
          ),
          Container(
            height: 100,
            width: 100,
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
          const SizedBox(
            height: 10,
          ),
          Text(
            'Dr.${controller.doctor.firstName} ${controller.doctor.lastName}',
            style: textTheme.booldTextWhite,
          ),
          Text(
            '${controller.doctor.specialty}',
            style: textTheme.greyText,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () async {
                    await controller.callDoctor();
                  },
                  icon: const Icon(
                    Icons.call,
                    color: ColorTheme.white,
                    size: 25,
                  )),
              IconButton(
                  onPressed: () {
                    controller.goToConversationScreen();
                  },
                  icon: const Icon(
                    Icons.chat,
                    color: ColorTheme.white,
                    size: 25,
                  )),
            ],
          ),
        ],
      ),
    ),
  );
}
