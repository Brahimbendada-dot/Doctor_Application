import 'package:doctor_c/model/doctor.dart';
import 'package:doctor_c/style/colors.dart';
import 'package:doctor_c/style/textStyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget DoctorWidget(BuildContext context, Doctor doctor) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.4,
    height: 200,
    decoration: BoxDecoration(
      color: ColorTheme.greyBackGround,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Column(
      children: [
        Container(
          height: 100,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              image: DecorationImage(
                  fit: BoxFit.fill, image: NetworkImage(doctor.photo))),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          'Dr.${doctor.firstName} ${doctor.lastName}',
          style: textTheme.booldTextBlack,
        ),
        Text(
          doctor.specialty,
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.star,
              color: Colors.yellow,
            ),
            Text('4.5')
          ],
        )
      ],
    ),
  );
}
