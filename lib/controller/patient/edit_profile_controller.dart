import 'dart:io';

import 'package:doctor_c/firebase_api/apis.dart';
import 'package:doctor_c/model/patient.dart';
import 'package:doctor_c/view/widgets/doctor/showLoading.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileController extends GetxController {
  Reference? reference;
  File? image;
  late Patient patient;
  late GlobalKey<FormState> formKey;

  pickImage(ImageSource source) async {
    var pick = await ImagePicker().pickImage(source: source);

    if (pick != null) {
      image = File(pick.path);
      reference = Apis.storage.ref("profile/${Apis.auth.currentUser!.uid}");
    }
    update();
  }

  saveChange(BuildContext context) async {
    final snackBar = SnackBar(content: const Text('Changes have been saved'));
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      showLoading(context);
      if (image != null) {
        await reference!.putFile(image!);
        patient.photo = await reference!.getDownloadURL();
      }
      await Apis.patientsDb
          .doc(Apis.auth.currentUser!.uid)
          .update(patient.toJson());
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    formKey = GlobalKey<FormState>();
    patient = Get.arguments['patient'];
  }
}
