import 'package:doctor_c/controller/patient/chat_screen_Controller.dart';
import 'package:doctor_c/model/doctor.dart';
import 'package:doctor_c/model/message.dart';
import 'package:doctor_c/style/colors.dart';
import 'package:doctor_c/style/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget MessageWidget(BuildContext context, Doctor doctor) {
  ChatScreenController controller = Get.put(ChatScreenController());
  Message? last_message;
  return Container(
    width: MediaQuery.of(context).size.width,
    margin: EdgeInsets.only(bottom: 5),
    height: 60,
    child: Center(
        child: StreamBuilder(
      stream: controller.getLastMessage(doctor),
      builder: (context, snapshot) {
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
                          fit: BoxFit.cover, image: NetworkImage(doctor.photo)),
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
                    Text('Dr.${doctor.firstName} ${doctor.lastName}', style: textTheme.booldTextBlack),
                    Flexible(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Text(
                            last_message != null ? last_message!.message : '',
                            style: textTheme.greyText),
                      ),
                    )
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
