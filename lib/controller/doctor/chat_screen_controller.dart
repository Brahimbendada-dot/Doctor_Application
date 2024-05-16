import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_c/firebase_api/apis.dart';
import 'package:doctor_c/functions/capitalize_first_letter.dart';
import 'package:doctor_c/model/message.dart';
import 'package:doctor_c/model/patient.dart';
import '../../view/screens/doctor/conversation_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatScreenController extends GetxController {
  Message? lastMessage;
  List<Patient> patients = [];
  List<Patient> searchPatients = [];
  List<Message> messages = [];
  late TextEditingController searchController;
  bool isSearch = false;

  checkSearch(String val) {
    if (val == '') {
      isSearch = false;
      update();
    }
  }

  onSearch() {
    isSearch = true;
    update();
  }

  searchPateint() {
    return Apis.patientsDb.orderBy('name').startAt(
        [capitalizeFirstLetter(searchController.text.toString())]).endAt([
      capitalizeFirstLetter(searchController.text.toString()) + '\uf8ff'
    ]).snapshots();
  }

  Stream<QuerySnapshot> getPatients() {
    return Apis.patientsDb.snapshots();
  }

  Stream<QuerySnapshot> getLastMessage(Patient patient) {
    return Apis.firestore
        .collection('chats/${Apis.getConversaitionId(patient.id)}/messages')
        .orderBy('sent', descending: true)
        .limit(1)
        .snapshots();
  }

  goToConversationScreen(int index) {
    Get.to(() => ConversationScreen(), arguments: {
      'patient': patients[index],
    });
  }

  goToConversationScreenFromSearch(int index) {
    Get.to(() => ConversationScreen(), arguments: {
      'patient': searchPatients[index],
    });
  }

  @override
  void onInit() {
    super.onInit();
    searchController = TextEditingController();
  }
}
