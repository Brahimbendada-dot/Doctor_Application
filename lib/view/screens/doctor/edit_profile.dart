import 'package:doctor_c/controller/doctor/edit_profile_controller.dart';
import 'package:doctor_c/functions/validation.dart';
import 'package:doctor_c/view/widgets/doctor/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../widgets/doctor/header_edit_profile.dart';
import '../../widgets/doctor/input_edit_profile.dart';
import '../../widgets/doctor/input_edit_profile_about.dart';

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
                InputEditProfile(controller.doctor.firstName, Icons.person, 'Name',
                    (val) => validation(val, 'user_name'), (val) {
                  controller.doctor.firstName = val!;
                }, TextInputType.text),
                InputEditProfile(controller.doctor.lastName, Icons.person, 'Name',
                    (val) => validation(val, 'user_name'), (val) {
                  controller.doctor.lastName = val!;
                }, TextInputType.text),
                InputEditProfileAbout(controller.doctor.about, Icons.info,
                    'About', (val) => validation(val, 'user_name'), (val) {
                  controller.doctor.about = val!;
                }),
                InputEditProfile(controller.doctor.phone, Icons.phone, 'Phone',
                    (val) => validation(val, 'phone'), (val) {
                  controller.doctor.phone = val!;
                }, TextInputType.phone),
                InputEditProfile(controller.doctor.address, Icons.location_on,
                    'Address', (val) => validation(val, 'address'), (val) {
                  controller.doctor.address = val!;
                }, TextInputType.text),
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
