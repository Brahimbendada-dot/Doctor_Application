import 'package:doctor_c/controller/doctor/chat_screen_controller.dart';
import 'package:doctor_c/model/message.dart';
import 'package:doctor_c/model/patient.dart';
import 'package:doctor_c/style/colors.dart';
import 'package:doctor_c/style/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget MessageWidget(BuildContext context, Patient patient) {
  ChatScreenController controller = Get.put(ChatScreenController());
  Message? last_message;
  return Container(
    width: MediaQuery.of(context).size.width,
    margin: EdgeInsets.only(bottom: 5),
    height: 60,
    child: Center(
        child: StreamBuilder(
      stream: controller.getLastMessage(patient),
      builder: (context, AsyncSnapshot snapshot) {
        final list = snapshot.data?.docs
                .map((e) => Message.fromJson(e.data()))
                .toList() ??
            [];
        if (list.isNotEmpty) {
          last_message = list[0];
        }
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(patient.photo)),
                      color: ColorTheme.white,
                      shape: BoxShape.circle),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${patient.firstName} ${patient.lastName}',
                        style: textTheme.booldTextBlack),
                    Flexible(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Text(
                            last_message != null ? last_message!.message : '',
                            style: textTheme.greyText),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(),
            )
          ],
        );
      },
    )),
  );
}
