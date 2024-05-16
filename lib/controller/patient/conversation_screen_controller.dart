import 'dart:convert';
import 'dart:io';
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
  late Doctor doctor;
  List messages = [];
  Reference? reference;
  late Patient patient;
  File? file;
  late TextEditingController messageController;

  Stream<QuerySnapshot> getMessages(Doctor doctor) {
    return Apis.firestore
        .collection('chats/${Apis.getConversaitionId(doctor.id)}/messages')
        .snapshots();
  }

  // Future<void> updateMessageReadStatus(Message message) async {
  // await Apis.firestore
  // .collection('chats/${Apis.getConversaitionId(message.fromId)}/messages')
  // .doc(message.sent)
  // .update({'read': DateTime.now().millisecondsSinceEpoch.toString()});
  // }

  sendMessage(Doctor doctor, String msg, Type type) {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    Message message = Message(
        fromId: Apis.currentAuthenticateuser.uid,
        toId: doctor.id,
        message: msg,
        sent: time,
        read: 'read',
        type: type);
    sendNotification(
        patientToken: doctor.token,
        title: patient.firstName + patient.lastName,
        content: msg);
    return Apis.firestore
        .collection('chats/${Apis.getConversaitionId(doctor.id)}/messages')
        .doc(time)
        .set(message.toJson());
  }

  Future<void> sendChatImage(Doctor doctor) async {
    final ext = file!.path.split('.').last;
    reference = Apis.storage.ref().child(
        "chat/${Apis.getConversaitionId(doctor.id)}/${DateTime.now().millisecondsSinceEpoch}.$ext");

    await reference!.putFile(file!).then((p0) {
      print('Data transfarred:${p0.bytesTransferred / 1000} kb');
    });
    final imageUrl = await reference!.getDownloadURL();
    await sendMessage(doctor, imageUrl, Type.image);
  }

  Future<Patient> getPatient() async {
    DocumentSnapshot snapshot =
        await Apis.patientsDb.doc(Apis.currentAuthenticateuser.uid).get();
    return Patient.fromJson(snapshot.data() as Map<String, dynamic>);
  }

  pickImage(ImageSource source) async {
    var pick = await ImagePicker().pickImage(source: source);
    if (pick != null) {
      file = File(pick.path);
      update();
      sendChatImage(doctor);
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
    doctor = Get.arguments['doctor'];
    patient = await getPatient();
  }
}
