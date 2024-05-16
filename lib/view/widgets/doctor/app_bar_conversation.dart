import 'package:doctor_c/controller/doctor/conversation_screen_controller.dart';
import 'package:doctor_c/style/colors.dart';
import 'package:doctor_c/style/textStyle.dart';
import 'package:flutter/material.dart';

Widget AppBarConversation(
    BuildContext context, ConversationScreenController controller) {
  return Row(
    children: [
      IconButton(
        onPressed: () {
          print('closed');
          Navigator.of(context).pop();
        },
        icon: const Icon(
          Icons.arrow_back,
          color: ColorTheme.white,
        ),
      ),
      Container(
        height: 45,
        width: 45,
        decoration: BoxDecoration(
            color: ColorTheme.greyBackGround,
            shape: BoxShape.circle,
            border: Border.all(
              color: ColorTheme.white,
              width: 2,
            ),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(controller.patient.photo),
            )),
      ),
      const SizedBox(
        width: 8,
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Dr.'${controller.patient.firstName} ${controller.patient.lastName}'",
            style: textTheme.booldTextWhite,
          )
        ],
      )
    ],
  );
}
