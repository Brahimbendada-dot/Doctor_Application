import 'package:doctor_c/controller/doctor/conversation_screen_controller.dart';
import 'package:doctor_c/model/message.dart';
import 'package:doctor_c/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Widget InputChatMessage(ConversationScreenController controller) {
  return Row(
    children: [
      Expanded(
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Row(
            children: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.emoji_emotions,
                    color: ColorTheme.primary,
                  )),
              Expanded(
                  child: Container(
                child: TextFormField(
                  controller: controller.messageController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Type something...',
                      hintStyle: TextStyle(color: ColorTheme.primary)),
                ),
              )),
              IconButton(
                  onPressed: () {
                    controller.pickImage(ImageSource.camera);
                  },
                  icon: const Icon(
                    Icons.camera_alt_rounded,
                    color: ColorTheme.primary,
                  )),
              IconButton(
                  onPressed: () {
                    controller.pickImage(ImageSource.gallery);
                  },
                  icon: const Icon(
                    Icons.image_rounded,
                    color: ColorTheme.primary,
                  )),
            ],
          ),
        ),
      ),
      Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
              color: ColorTheme.primary, shape: BoxShape.circle),
          child: Center(
            child: IconButton(
                onPressed: () {
                  if (controller.messageController.text.isNotEmpty) {
                    controller.sendMessage(controller.patient,
                        controller.messageController.text, Type.text);
                    controller.messageController.text = '';
                  }
                },
                icon: const Icon(
                  Icons.send,
                  size: 24,
                  color: ColorTheme.white,
                )),
          ))
    ],
  );
}
