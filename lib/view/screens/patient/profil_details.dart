import 'package:doctor_c/controller/patient/profile_details_controller.dart';
import 'package:doctor_c/view/widgets/doctor/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/patient/container_profile_details.dart';
import '../../widgets/patient/header_profile_details.dart';

class ProfileDetails extends StatelessWidget {
  const ProfileDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ProfileDetailsController>(
          init: ProfileDetailsController(),
          builder: (controller) => Container(
                child: Column(
                  children: [
                    HeaderProfileDetails(context, controller),
                    const SizedBox(
                      height: 20,
                    ),
                    ContainerProfileDetails(
                        context,
                        Icons.person,
                        '${controller.patient.firstName} ${controller.patient.lastName}',
                        'Name'),
                    ContainerProfileDetails(context, Icons.person,
                        controller.patient.email, 'Email'),
                    ContainerProfileDetails(context, Icons.person,
                        controller.patient.phone, 'Phone'),
                    ContainerProfileDetails(context, Icons.person,
                        controller.patient.address, 'Address'),
                    const SizedBox(
                      height: 20,
                    ),
                    Button(
                        'Edit Profile', () => controller.goToEditProfilePage()),
                  ],
                ),
              )),
    );
  }
}
