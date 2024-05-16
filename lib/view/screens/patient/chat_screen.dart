import 'package:doctor_c/controller/patient/chat_screen_Controller.dart';
import 'package:doctor_c/model/doctor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/patient/chat_search_input.dart';
import '../../widgets/patient/message_widget.dart';

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
                      stream: controller.searchDoctor(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          controller.doctorsSearch = snapshot.data!.docs
                              .map<Doctor>((e) => Doctor.fromJson(e.data()))
                              .toList();
                          return ListView.builder(
                              shrinkWrap: true,
                              itemCount: controller.doctorsSearch.length,
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
                                                  .doctorsSearch[index]
                                                  .photo))),
                                    ),
                                    title: Text(
                                        '${controller.doctorsSearch[index].firstName} ${controller.doctorsSearch[index].lastName}'),
                                    subtitle: Text(controller
                                        .doctorsSearch[index].specialty),
                                  ),
                                );
                              });
                        }
                        return Center(
                          child: Container(),
                        );
                      })
                  : StreamBuilder(
                      stream: controller.getDoctors(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          controller.doctors = snapshot.data!.docs
                              .map<Doctor>((e) => Doctor.fromJson(e.data()))
                              .toList();
                          return ListView.builder(
                              shrinkWrap: true,
                              itemCount: controller.doctors.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () =>
                                      controller.goToConversationScreen(index),
                                  child: MessageWidget(
                                      context, controller.doctors[index]),
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
