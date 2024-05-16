import 'package:doctor_c/firebase_api/apis.dart';
import '../../view/screens/doctor/Auth/logIn.dart';
import '../../view/screens/doctor/appointment_screen.dart';
import '../../view/screens/doctor/chat_screen.dart';
import '../../view/screens/doctor/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class DoctorAppController extends GetxController {
  int _selectedIndex = 0;
  final List<Widget> _screens = const [
    ChatScreen(),
    AppointmentScreen(),
    ProfileScreen()
  ];

  checkAuthentificationUser() {
    Apis.auth.authStateChanges().listen((user) {
      if (user == null) {
        Get.offAll(() => const LogIn());
      }
    });
  }

  Future<String> getDeviceToken() async {
    String? token = await Apis.messaging.getToken();
    return token!;
  }

  updateDeviceToken() async {
    getDeviceToken().then((value) {
      Apis.auth.authStateChanges().listen((event) async {
        if (event != null) {
          await Apis.doctorsDb
              .doc(Apis.currentAuthenticateuser.uid)
              .update({'token': value});
        }
      });
    });
  }

  List<Widget> get screenPage => _screens;
  int get selectedIndex => _selectedIndex;
  changeScreen(int index) {
    _selectedIndex = index;
    update();
  }

  @override
  void onInit() async {
    checkAuthentificationUser();
    await updateDeviceToken();
    // TODO: implement onInit
    super.onInit();
  }
}
