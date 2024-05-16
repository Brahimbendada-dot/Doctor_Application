import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_c/firebase_api/apis.dart';
import '../../../view/screens/doctor/Auth/create_account.dart';
import '../../../view/screens/doctor/doctor_app.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../view/widgets/doctor/showLoading.dart';

class LogInController extends GetxController {
  late TextEditingController password_controller;
  late TextEditingController email_controller;

  bool obscureText = true;
  IconData hidden_visible_eye = Icons.remove_red_eye;

  goToCreatAccountPage() {
    Get.offAll(() => const CreateAccount());
  }

  logIn(BuildContext context) async {
    showLoading(context);
    try {
      await Apis.auth.signInWithEmailAndPassword(
          email: email_controller.text, password: password_controller.text);
      Get.offAll(() => const DoctorApp());
    } on FirebaseException catch (e) {
      if (e.code == 'unknown') {
        final snackBar = SnackBar(content: Text("Wrong password or email"));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      if (e.code == 'invalid-email') {
        final snackBar = SnackBar(content: Text("invalid email"));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  void show_hidde_Password() {
    obscureText = !obscureText;
    if (!obscureText) {
      hidden_visible_eye = Icons.remove_red_eye_outlined;
    } else {
      hidden_visible_eye = Icons.remove_red_eye;
    }
    update();
  }

  @override
  void onInit() {
    super.onInit();
    password_controller = TextEditingController();
    email_controller = TextEditingController();

    // TODO: implement onInit
  }
}
