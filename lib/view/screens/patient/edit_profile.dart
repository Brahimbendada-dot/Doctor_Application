import 'package:doctor_c/controller/patient/edit_profile_controller.dart';
import 'package:doctor_c/functions/validation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/doctor/button.dart';
import '../../widgets/patient/header_edit_profile.dart';
import '../../widgets/patient/input_edit_profile.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<EditProfileController>(
      init: EditProfileController(),
      builder: (controller) => Container(
        child: Form(
          key: controller.formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                HeaderEditProfile(context, controller),
                const SizedBox(
                  height: 20,
                ),
                InputEditProfile(controller.patient.firstName, Icons.person,
                    'Name', (val) => validation(val, 'user_name'), (val) {
                  controller.patient.firstName = val!;
                }),
                InputEditProfile(controller.patient.lastName, Icons.person,
                    'Name', (val) => validation(val, 'user_name'), (val) {
                  controller.patient.lastName = val!;
                }),
                InputEditProfile(controller.patient.phone, Icons.phone, 'Phone',
                    (val) => validation(val, 'phone'), (val) {
                  controller.patient.phone = val!;
                }),
                InputEditProfile(controller.patient.address, Icons.location_on,
                    'Address', (val) => validation(val, 'address'), (val) {
                  controller.patient.address = val!;
                }),
                const SizedBox(
                  height: 30,
                ),
                Button('Save Change', () => controller.saveChange(context))
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
