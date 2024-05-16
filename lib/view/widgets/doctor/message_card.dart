import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_c/firebase_api/apis.dart';
import 'package:doctor_c/functions/my_date_util.dart';
import 'package:doctor_c/model/message.dart';
import 'package:doctor_c/style/colors.dart';
import 'package:flutter/material.dart';

class MessageCard extends StatelessWidget {
  final Message message;
  const MessageCard({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return message.fromId == Apis.currentAuthenticateuser.uid.toString()
        ? _primaryMessage(context)
        : _greyMessage(context);
  }

  Widget _primaryMessage(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Center(
          child: Text(
              MyDateUtil.getFormatedDate(context: context, time: message.sent)),
        ),
        const SizedBox(
          width: 10,
        ),
        Flexible(
          child: Container(
              margin: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.width * 0.04,
                  horizontal: MediaQuery.of(context).size.width * 0.01),
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                ),
                color: ColorTheme.primary,
              ),
              child: message.type == Type.text
                  ? Text(
                      message.message,
                      style: const TextStyle(color: Colors.white, fontSize: 15),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: CachedNetworkImage(
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(
                          color: ColorTheme.white,
                        ),
                        imageUrl: message.message,
                      ),
                    )),
        ),
      ],
    );
  }

  Widget _greyMessage(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Container(
              margin: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.width * 0.04,
                  horizontal: MediaQuery.of(context).size.width * 0.01),
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                color: ColorTheme.grey,
              ),
              child: message.type == Type.text
                  ? Text(
                      message.message,
                      style: const TextStyle(color: Colors.white, fontSize: 15),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: CachedNetworkImage(
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(
                          color: ColorTheme.white,
                        ),
                        imageUrl: message.message,
                      ),
                    )),
        ),
        const SizedBox(
          width: 10,
        ),
        Center(
          child: Text(
              MyDateUtil.getFormatedDate(context: context, time: message.sent)),
        ),
      ],
    );
  }
}
