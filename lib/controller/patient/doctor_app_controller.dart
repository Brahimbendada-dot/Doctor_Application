import 'package:doctor_c/firebase_api/apis.dart';
import 'package:doctor_c/view/screens/patient/appointment_screen.dart';
import 'package:doctor_c/view/screens/patient/authentification/login.dart';
import 'package:doctor_c/view/screens/patient/chat_screen.dart';
import 'package:doctor_c/view/screens/patient/home_screen.dart';
import 'package:doctor_c/view/screens/patient/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PatientAppController extends GetxController {
  int _selectedIndex = 0;
  final List<Widget> _screens = const [
    HomeScreen(),
    ChatScreen(),
    AppointmentScreen(),
    ProfileScreen()
  ];

  checkAuthentificationUser() {
    Apis.auth.authStateChanges().listen((user) {
      if (user == null) {
        Get.offAll(() => const LogInPatient());
      }
    });
  }

  List<Widget> get screenPage => _screens;
  int get selectedIndex => _selectedIndex;
  changeScreen(int index) {
    _selectedIndex = index;
    update();
  }

  @override
  void onInit() {
    checkAuthentificationUser();
    // TODO: implement onInit
    super.onInit();
  }
}
