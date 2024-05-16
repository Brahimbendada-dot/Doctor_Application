import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_c/firebase_api/apis.dart';
import 'package:doctor_c/functions/capitalize_first_letter.dart';
import 'package:doctor_c/model/doctor.dart';
import 'package:doctor_c/model/message.dart';
import 'package:doctor_c/view/screens/patient/conversation_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatScreenController extends GetxController {
  Message? lastMessage;
  List<Doctor> doctors = [];
  List<Doctor> doctorsSearch = [];
  List<Message> messages = [];
  bool isSearch = false;
  late TextEditingController searchController;

  checkSearch(String val) {
    if (val == '') {
      isSearch = false;
    }
    update();
  }

  onSearch() {
    isSearch = true;
    update();
  }

  searchDoctor() {
    return Apis.doctorsDb.orderBy('firstName').startAt(
        [capitalizeFirstLetter(searchController.text.toString())]).endAt([
      capitalizeFirstLetter(searchController.text.toString()) + '\uf8ff'
    ]).snapshots();
  }

  Stream<QuerySnapshot> getDoctors() {
    return Apis.doctorsDb.snapshots();
  }

  Stream<QuerySnapshot> getLastMessage(Doctor doctor) {
    return Apis.firestore
        .collection('chats/${Apis.getConversaitionId(doctor.id)}/messages')
        .orderBy('sent', descending: true)
        .limit(1)
        .snapshots();
  }

  goToConversationScreen(int index) {
    Get.to(() => ConversationScreen(), arguments: {
      'doctor': doctors[index],
    });
  }

  goToConversationScreenFromSearch(int index) {
    Get.to(() => ConversationScreen(), arguments: {
      'doctor': doctorsSearch[index],
    });
  }

  @override
  void onInit() {
    super.onInit();
    searchController = TextEditingController();
  }
}
