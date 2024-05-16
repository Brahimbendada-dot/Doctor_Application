import 'package:doctor_c/controller/doctor/conversation_screen_controller.dart';
import 'package:doctor_c/model/message.dart';
import 'package:doctor_c/style/colors.dart';
import 'package:doctor_c/style/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/doctor/app_bar_conversation.dart';
import '../../widgets/doctor/input_chat_message.dart';
import '../../widgets/doctor/message_card.dart';

class ConversationScreen extends StatelessWidget {
  const ConversationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ConversationScreenController>(
      init: ConversationScreenController(),
      builder: (controller) => SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: ColorTheme.primary,
            automaticallyImplyLeading: false,
            flexibleSpace:
                Center(child: AppBarConversation(context, controller)),
          ),
          body: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Expanded(
                  child: StreamBuilder(
                    stream: controller.getMessages(controller.patient),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        controller.messages = snapshot.data!.docs
                            .map<Message>((e) => Message.fromJson(e.data()))
                            .toList();
                        if (controller.messages.isNotEmpty) {
                          return ListView.builder(
                              shrinkWrap: true,
                              itemCount: controller.messages.length,
                              itemBuilder: (context, index) {
                                return MessageCard(
                                    message: controller.messages[index]);
                              });
                        } else {
                          return const Center(
                              child: Text(
                            "say hello 👋",
                            style: textTheme.booldTextBlack,
                          ));
                        }
                      }
                      return const Center(
                        child: CircularProgressIndicator(
                          color: ColorTheme.primary,
                        ),
                      );
                    },
                  ),
                ),
                InputChatMessage(controller),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
