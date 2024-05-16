import 'package:doctor_c/controller/doctor/chat_screen_controller.dart';
import 'package:doctor_c/model/patient.dart';
import 'package:doctor_c/style/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/doctor/chat_search_input.dart';
import '../../widgets/doctor/message_widget.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<ChatScreenController>(
      init: ChatScreenController(),
      builder: (controller) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView(
            children: [
              ChatSearchInput(context, controller, 1),
              const SizedBox(
                height: 20,
              ),
              controller.isSearch
                  ? StreamBuilder(
                      stream: controller.searchPateint(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          controller.searchPatients = snapshot.data!.docs
                              .map<Patient>((e) => Patient.fromJson(e.data()))
                              .toList();
                          return ListView.builder(
                              shrinkWrap: true,
                              itemCount: controller.searchPatients.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () => controller
                                      .goToConversationScreenFromSearch(index),
                                  child: ListTile(
                                    leading: Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(controller
                                                  .searchPatients[index]
                                                  .photo))),
                                    ),
                                    title: Text(
                                      '${controller.searchPatients[index].firstName} ${controller.searchPatients[index].lastName} ',
                                      style: textTheme.booldTextBlack,
                                    ),
                                  ),
                                );
                              });
                        }
                        return Center(
                          child: Container(),
                        );
                      })
                  : StreamBuilder(
                      stream: controller.getPatients(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          controller.patients = snapshot.data!.docs
                              .map<Patient>((e) => Patient.fromJson(e.data()))
                              .toList();
                          return ListView.builder(
                              shrinkWrap: true,
                              itemCount: controller.patients.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () =>
                                      controller.goToConversationScreen(index),
                                  child: MessageWidget(
                                      context, controller.patients[index]),
                                );
                              });
                        }
                        return Center(
                          child: Container(),
                        );
                      })
            ],
          ),
        ),
      ),
    ));
  }
}
