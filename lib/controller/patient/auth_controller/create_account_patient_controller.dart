import 'package:doctor_c/view/screens/patient/patient_app.dart';
import 'package:doctor_c/firebase_api/apis.dart';
import 'package:doctor_c/model/patient.dart';
import 'package:doctor_c/view/screens/patient/authentification/login.dart';
import 'package:doctor_c/view/widgets/doctor/showLoading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateAccountPatientController extends GetxController {
  late TextEditingController firstName_controller;
  late TextEditingController lastName_controller;
  late TextEditingController email_controller;
  late TextEditingController firstPassword_controller;
  late TextEditingController secondPassword_controller;
  late TextEditingController phone_controller;
  late TextEditingController address_controller;
  late GlobalKey<FormState> formKey;

  createUser(UserCredential userCredential) async {
    DateTime date = DateTime.now();
    Patient patient = Patient(
      dateCreatAccount: date,
      id: userCredential.user!.uid,
      firstName: firstName_controller.text,
      lastName: lastName_controller.text,
      photo:
          'https://firebasestorage.googleapis.com/v0/b/doctor-307f5.appspot.com/o/profile%2Fprofile.jpg?alt=media&token=b360820d-8a84-4efc-8769-ca2fa03a1ac0',
      email: email_controller.text,
      address: address_controller.text,
      phone: phone_controller.text,
      token: 'token',
    );
    Apis.patientsDb.doc(Apis.auth.currentUser!.uid).set(patient.toJson());
  }

  createAccount(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      showLoading(context);
      if (firstPassword_controller.text == secondPassword_controller.text) {
        try {
          UserCredential userCredential = await Apis.auth
              .createUserWithEmailAndPassword(
                  email: email_controller.text,
                  password: firstPassword_controller.text);
          createUser(userCredential);
          goToApplication();
        } on FirebaseException catch (e) {
          final snackBar = SnackBar(content: Text(e.code));
          if (e.code == "email-already-in-use" || e.code == 'weak-password') {
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        }
      } else {
        final snackBar = SnackBar(content: Text('Passwords do not match'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  goToLogInPage() {
    Get.to(() => const LogInPatient());
  }

  goToApplication() {
    Get.offAll(() => const PatientApp());
  }

  @override
  void onInit() {
    firstName_controller = TextEditingController();
    lastName_controller = TextEditingController();
    email_controller = TextEditingController();
    firstPassword_controller = TextEditingController();
    secondPassword_controller = TextEditingController();
    phone_controller = TextEditingController();
    address_controller = TextEditingController();
    formKey = GlobalKey<FormState>();
    // TODO: implement onInit
    super.onInit();
  }
}
