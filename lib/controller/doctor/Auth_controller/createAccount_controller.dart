import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_c/firebase_api/apis.dart';
import 'package:doctor_c/model/doctor.dart';
import 'package:doctor_c/model/specialty.dart';
import 'package:doctor_c/view/widgets/doctor/showLoading.dart';
import '../../../view/screens/doctor/doctor_app.dart';
import '../../../view/screens/doctor/Auth/logIn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateAccountController extends GetxController {
  List specialties = [];
  var specialty;
  late TextEditingController firstName_controller;
  late TextEditingController lastName_controller;
  late TextEditingController email_controller;
  late TextEditingController firstPassword_controller;
  late TextEditingController secondPassword_controller;
  late TextEditingController phone_controller;
  late TextEditingController address_controller;
  late GlobalKey<FormState> formKey;

  getToken() async {
    String? token = await Apis.messaging.getToken();
    return token;
  }

  setSpecialty(var val) {
    specialty = val;
    update();
  }

  goToLogInPage() {
    Get.to(() => const LogIn());
  }

  goToApplication() {
    Get.offAll(() => const DoctorApp());
  }

  createDoctor(UserCredential userCredential) async {
    DateTime date = DateTime.now();
    Doctor doctor = Doctor(
      dateCreatAccount: date,
      id: userCredential.user!.uid,
      firstName: firstName_controller.text,
      lastName: lastName_controller.text,
      photo:
          'https://firebasestorage.googleapis.com/v0/b/doctor-307f5.appspot.com/o/profile%2Fprofile.jpg?alt=media&token=b360820d-8a84-4efc-8769-ca2fa03a1ac0',
      email: email_controller.text,
      address: address_controller.text,
      phone: phone_controller.text,
      token: await getToken(),
      specialty: specialty.toString(),
      about: 'about ',
      
    );
    await Apis.doctorsDb.doc(doctor.id).set(doctor.toJson());
  }

  Future getSpecialties() async {
    QuerySnapshot snapshot = await Apis.specialtiesDb.get();
    specialties =
        snapshot.docs.map((e) => Specialty.fromJson(e.data())).toList();
    update();
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

          createDoctor(userCredential);
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

  @override
  void onInit() {
    getSpecialties();
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
