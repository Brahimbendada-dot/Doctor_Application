import 'dart:io';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_c/firebase_api/apis.dart';
import 'package:doctor_c/model/doctor.dart';
import 'package:doctor_c/model/message.dart';
import 'package:doctor_c/model/patient.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class ConversationScreenController extends GetxController {
  late Patient patient;
  late Doctor doctor;
  List<Message> messages = [];
  Reference? reference;
  File? file;
  late TextEditingController messageController;

  Stream<QuerySnapshot> getMessages(Patient patient) {
    return Apis.firestore
        .collection('chats/${Apis.getConversaitionId(patient.id)}/messages')
        .snapshots();
  }

  Future<Doctor> getDoctor() async {
    DocumentSnapshot snapshot =
        await Apis.doctorsDb.doc(Apis.currentAuthenticateuser.uid).get();
    return Doctor.fromJson(snapshot.data());
  }

  sendMessage(Patient patient, String msg, Type type) {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    Message message = Message(
        fromId: Apis.currentAuthenticateuser.uid,
        toId: patient.id,
        message: msg,
        sent: time,
        read: 'read',
        type: type);
    sendNotification(
        patientToken: patient.token, title: 'Dr.${doctor.firstName} ${doctor.lastName}', content: msg);
    return Apis.firestore
        .collection('chats/${Apis.getConversaitionId(patient.id)}/messages')
        .doc(time)
        .set(message.toJson());
  }

  Future<void> sendChatImage(Patient patient) async {
    final ext = file!.path.split('.').last;
    reference = Apis.storage.ref().child(
        "chat/${Apis.getConversaitionId(patient.id)}/${DateTime.now().millisecondsSinceEpoch}.$ext");

    await reference!.putFile(file!).then((p0) {
      print('Data transfarred:${p0.bytesTransferred / 1000} kb');
    });
    final imageUrl = await reference!.getDownloadURL();
    await sendMessage(patient, imageUrl, Type.image);
  }

  pickImage(ImageSource source) async {
    var pick = await ImagePicker().pickImage(source: source);
    if (pick != null) {
      file = File(pick.path);
      update();
      sendChatImage(patient);
    }
  }

  Future<String> getDeviceToken() async {
    String? token = await Apis.messaging.getToken();
    return token!;
  }

  sendNotification(
      {required String patientToken,
      required String title,
      required String content}) {
    getDeviceToken().then((value) async {
      var data = {
        'to': patientToken,
        'priority': 'high',
        'notification': {
          'title': title,
          'body': content,
        }
      };
      var response = await http.post(
          Uri.parse('https://fcm.googleapis.com/fcm/send'),
          body: jsonEncode(data),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'key=${Apis.KeyApi}'
          });
      print(response.statusCode);
    });
  }

  @override
  void onInit() async {
    super.onInit();
    // TODO: implement onInit
    messageController = TextEditingController();
    patient = Get.arguments['patient'];
    doctor = await getDoctor();
  }
}
